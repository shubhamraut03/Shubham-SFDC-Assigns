/**
 *
 * Description   - Generic class to hold the lightning response details in form of an entity for uniformity everywhere.
 *
 *
 **/
public with sharing class LightningResponse {
  @AuraEnabled
  public String status { get; set; }
  @AuraEnabled
  public Boolean isSuccess { get; set; }
  @AuraEnabled
  public String message { get; set; }
  @AuraEnabled
  public Object body { get; set; }

  public LightningResponse() {
    this.status = 'Success';
    this.isSuccess = true;
  }

  public static LightningResponse create() {
    return new LightningResponse();
  }

  public static LightningResponse create(Object body) {
    return LightningResponse.create().setBody(body);
  }

  public LightningResponse setSuccess(Boolean isSuccess) {
    this.status = isSuccess ? 'Success' : 'Error';
    this.isSuccess = isSuccess;
    return this;
  }

  public LightningResponse setError(String errorMessage) {
    this.status = 'Error';
    this.isSuccess = false;
    return this.setMessage(errorMessage);
  }

  public LightningResponse setWarning(String warningMessage) {
    this.status = 'Warning';
    return this.setMessage(warningMessage);
  }

  public LightningResponse setMessage(String message) {
    this.message = message;
    return this;
  }

  public LightningResponse setBody(Object body) {
    this.body = body;
    return this;
  }

  public static LightningResponse success(Object body) {
    return LightningResponse.create(body);
  }

  public static LightningResponse success(String successMessage) {
    return LightningResponse.create().setMessage(successMessage);
  }

  public static LightningResponse success(Object body, String successMessage) {
    return LightningResponse.create(body).setMessage(successMessage);
  }

  public static LightningResponse error(Object body) {
    return LightningResponse.create(body).setSuccess(false);
  }

  public static LightningResponse error(String errorMessage) {
    return LightningResponse.create().setError(errorMessage);
  }

  public static LightningResponse error(Object body, String errorMessage) {
    return LightningResponse.create(body).setError(errorMessage);
  }
}