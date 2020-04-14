package io.appy.domain;

import org.joda.time.DateTime;

import java.util.Date;

public class NotificationRequest {

    String title;
    String body;
    Date dateTime;

    public NotificationRequest() {
    }

    public NotificationRequest(String title, String body, Date dateTime) {
        this.title = title;
        this.body = body;
        this.dateTime = dateTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }
}
