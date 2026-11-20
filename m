Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174506;
	b=XbVEhyCSRfLal0HWfEmQ1yUMhZa16fwpxZhRfvIRTm+Zc+63tT+APvanWPAXF26NGyzk
	 pUno09xQU+133t7iaEb/4syAJTe78tYrDeQXL8fAMbBp0j/meyLC6aIejPl12S27smB69
	 QGesXSZvEsvlkzu+kr2zcVTrDFszfStRNy+7xA7hKBbSeysgaIgSCJ4zJ0YRNBgnZxCxt
	 3C6PwsNOMDSl4t8+oPQFbZwnFtQqtrPFXZgqnSVItpNwjF/XvDUPAsEIz7JzmRTeuGKCJ
	 ZmcJCoFiakI3zuoTLOKZf5XuuMkhmdjiEFVVfeP2BkwONQ8sFgR9Iz7eQ65rl5k6+pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bkrqVl4fOtFiXo/UNE5/tK7V61bZnqlZiu3NzPQivMI=;
	b=J6vHcid+1AL+1O0wYIy7o8g1KPaL+CvSjmmfdsMQ3saIRE9u24y1TweWLR45RXVdDWfj
	 go8moPGtlNVyKKro9CfExfFEyFpxDk7sXYzTDcdpJBeJKOQFih5DumTuxVHqwKiB2SUJe
	 GmzUBZ5SZcB3L/KaMx3Tbn/Hyu6+hV+j/dxMJUCbp5HnT7w17r2huk2U9zwEn2S7K00GL
	 vmlfmrn3j6n+f2quupCLAX4auN3O3WxaFRgJoYIb8LMIMEptvM4kTzF/cf+I+8W3PChN9
	 /OfUijgoYAu/WnFWKaUQd04wnFndx8EuspPdCS38jqEiPGKzC/9+VwxhnyrEdnyvVDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W6WXLOxR;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE1606A330
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 11:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ADE1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W6WXLOxR
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c49df8fe86eso86880366b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 03:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795174505; x=1795779305; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkrqVl4fOtFiXo/UNE5/tK7V61bZnqlZiu3NzPQivMI=;
        b=W6WXLOxR59uIfbaLpHw1RDG/aYC7BEPo6GMxxJsEX9hnvcfGjS1k3ZxVFqUv0AFkjU
         0HKbTZarlk3QbD7la/aeB8WWyj+L/d5uqI0/Kldt/z/TyOE1+EH/09J3/nHTMQyK0IBx
         jSis/yb2mQuZrhseR1h8momD+rFSWBeTNFj84rX/cxm2Dnpnmfrw8z/DCwxAxLfXy2Ur
         mKJvD3oJuijaym9T8sS6/FoceuszJAg3EDkJLxqhHXEGmp09BkqY60UVtQ1/yZMV4Kcy
         hZHrQmG+9lVrEffHnUR4gsfHbCOME9UhqkRa+c6QImLe+mLEXqYh+04zjVrAMvWLEN3A
         JZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795174505; x=1795779305;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkrqVl4fOtFiXo/UNE5/tK7V61bZnqlZiu3NzPQivMI=;
        b=NdF4FBP7TcsS8Y//UBvyPyF0wUWOVoB+xF9uAq/rdxdxMFOQK0S873OGpYwjdjLJtT
         uC1ZSlfusPyBnekP9Br6X11gJbbQzf1Kcs8ah1F7EJrSVyFA7KiEs7zLI6xSvZ/bCdFL
         dT/XFGsoA0mKDN8UsZvChXiKG51kciAzVguuiTmuTJ/lmZEY2HNyHIEW0+1n3ECRKg2N
         R7sRJZmJmlEhI1Z8+WjMauAbEGgyO/2lqk3naeRG4MMCmduJbCFaQvzCJr20DnOgOcGi
         CeqO3VsHFYIl/0h/W7EVWkaFdjA6G5ruxnw+so6ov2dnIw8Pms50dOhAA+/5vqaaHicG
         yP2w==
X-Forwarded-Encrypted: i=1; AL+hErG2HmQsVwp3YUzD9RR8YJF1z1gXM5s41x+J31hCVe8kaGIoES2AVfzptl+HLUPvpORaXuAo1SRk0WfwFPtf@vger.kernel.org
X-Gm-Message-State: APuU4Z9lytvxEOeRRp8Ob3S+U/+q7JETb5nzkHs8moB9BAbg/EqQBnne
	9RSzVYhz5zZesWuKBZpwqQar+tYlQsZXk7seHxdvEu+X7YJxzhO34ZaPdhg0/qbuTt5EigYjKw=
	=
X-Received: from ejcmy22.prod.google.com ([2002:a17:906:5a56:b0:c50:5767:f11e])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3e28:b0:c41:7e99:c6c2
 with SMTP id a640c23a62f3a-c513ac99405mr295016666b.44.1795174504655; Fri, 20
 Nov 2026 03:35:04 -0800 (PST)
Date: Fri, 20 Nov 2026 11:35:04 +0000
In-Reply-To: <sashiko-outbox-223014@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119104208.782900-1-halg@google.com> <20261119104208.782900-2-halg@google.com>
 <sashiko-outbox-223014@kernel.org>
Message-ID: <awAwaJugal622uZf@google.com>
Subject: Re: [PATCH v2 1/4] userns: introduce capability bounding set for user namespaces
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: sashiko-reviews@lists.linux.dev, Christian Brauner <brauner@kernel.org>, 
	Serge Hallyn <sergeh@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Jonathan Calmels <jcalmels@3xx0.net>, Jann Horn <jannh@google.com>, 
	"=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	containers@lists.linux.dev, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Nov 19, 2026 at 11:11:50AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does bounding implicit owner capabilities by userns_has_cap(ns, cap) break
> cap_ptrace_access_check() and cap_ptrace_traceme() for a parent namespace
> owner when CAP_SYS_PTRACE is excluded from the child namespace's cap_bset?

This is working as intended. Implicit parent-owner capabilities in
cap_capable_helper() are uniformly bounded by the owned namespace's
cap_bset.

Concretely, this only prevents an unprivileged parent task from
getting implicit CAP_SYS_PTRACE via ownership of a child userns
where CAP_SYS_PTRACE was explicitly stripped. Holding explicit
CAP_SYS_PTRACE in an ancestor userns (or owning an ancestor userns
that still includes CAP_SYS_PTRACE) still allows tracing.

This is also unlikely to come up in practice, since typical denylist
configurations would only strip high-risk capabilities like
CAP_NET_ADMIN and CAP_NET_RAW.

If we wanted to make an exception for ptrace() to still allow
same-UID owner tracing when CAP_SYS_PTRACE is stripped,
cap_ptrace_access_check() and cap_ptrace_traceme() already allow
same-userns tracing without CAP_SYS_PTRACE when the target's
capabilities (and userns ceiling) are a subset of the tracer's.
Extending that check across owned namespaces (similar to
cred_cap_issubset()) would be straightforward, though I'd prefer
to keep the stricter, uniform behavior in v2 unless there are
objections.
