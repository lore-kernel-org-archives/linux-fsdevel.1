Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D13F3273
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496332; cv=pass; b=VOWOm1+2yhw9o2ZCJYwJKGKmsnWQIoMlC9iQSnGKSBXU4pZvtwHMA1NGUzk7L3kyiY5DXrxR+wgwe1Q1yMZSCY6kQGp+eUlYgwCr+UkU3MxlNPekJq+R87Awah7A3DdZ+eMcfnhG3N0+qf4DmIib6pQdggxPSOERGGcOXMvN7q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496332; c=relaxed/simple;
	bh=kQon4ci3juIeb13a7BAUYGmkUEq9qgCZiXvMu88a/9g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qRZSDal4UDJbvB7saAJztentcuOuNvHp+1RXcUGV7c09co9oVJAiP6GMgWUDNGcZVJRQc/ZA9lBrjGmYZFhoyLjJykO5sr8vsn/Soyth/2Y7v7DzbxVAxt1VHwJzM/1o0rZH8gGWAKEtWz4Fra+yXyMRG0IkWx7eVhGPGaRoMPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN6kQVDA; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN6kQVDA"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-668296d0ff3so1102137d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 04:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785496329; cv=none;
        d=google.com; s=arc-20260327;
        b=J+X+4paYjV8/yYYJBls3VC6c4f4Al08CzbLrTzn1JWDobJgi0rQAhCZGYX7Amgxwp7
         Y9ILWIdtlRQmp3LaeruiYT3VEADEghIV0s/2ZmjTI39yMmjG9ktv954j0J+PSWT4HBVG
         LmgYCN4HLVqT1Nu72/T0gc8RXErgW9W6VWGyD29EmBvas9/jxxkV53s7NWV/08tDriVV
         1UETiMDyR8ChM5SK0O9m67L01orLb0NVDmfcZSeO3Vv2R8RMv08sf+4J8NMOP+fb+jUO
         UOzGlE3xotPxQsdnBWyjUw9JHGGrxE017EG9bg9mmHvpNI+6E3avLxmn/Ecz/TCd/78p
         4X0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vlFIZu1JNT0zE+f7MLVc0QneGIBHjmx5kUi+aBEagyI=;
        fh=HsVCrx5cSDwLSUr3CW+nnHV89MjAC5I0h1D7E5cSw+4=;
        b=HyVcqo9R5UrjdtT+oGrsv7RdpqNckgqO4vjxbnRhRXaT1IEKkhTBe0b/lz0JArWf8Q
         dG3rx9D6CJAcdIEMrZBXYOOvZUcde2vZn0sPNJaTOSWLTn7edMQpecWx69rZ2EuMh7Ua
         N+nzeECV+G5t/cP4qDcp35Py8tYwvKcFabEiMe6a20syS5HK991LubRcUnghVee2CWIn
         ULEgErlJhmdF4yC6Gt3bQCUpve+giX4uNQoPCI8EG4LvIu5Ca9DLqyE1oibK/uUXKbgi
         PG4DkXnQ0KRuJDKVMwhxFZCHE90O3gE/SQsb3W0RsiXXutuscLzt/xjQBcWOj6sGLJhz
         pNZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785496329; x=1786101129; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vlFIZu1JNT0zE+f7MLVc0QneGIBHjmx5kUi+aBEagyI=;
        b=IN6kQVDALhbcgAtR/7XtGjuF0frasaitMwd9gghI2GvJzTOr9p0e8prGsvdlmormte
         KqMDQbnsSwCmzpABVBsDYpasbPSirYnyjuYPgvC8SdxG7tge8UrNaS7oMWkB0OUHyYTc
         DVoFl+uz2smyz9SNZrRI5AmiVEtRAH4spyxXNdU3Mt7aGKzAfjaBcZjKNd+vM87xqsJ3
         uG1u25WMz7BfwMI60cTInXqNoyi9oOcPmSLeThnBPrWBuVq119WS8K6SDXEby5hrNoaB
         KXf7bicK6ouYONcdeeu1vyC9wl+g5uhmmarSzNlC/LCEjuAFmZ8mZj4WTOxqnc9Iw2xa
         we3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785496329; x=1786101129;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlFIZu1JNT0zE+f7MLVc0QneGIBHjmx5kUi+aBEagyI=;
        b=WyJGasOGnxRTgmd3QzJ3Zh2UNUP8+Z9cDZ+8in6hPd9P/KSkZ+Ghkur6GE0jGfiw7x
         lQcM8qZXPE/VxzZk9jFWCp8RvX5Evwcmj+CuYpJPwqVw5/vken3uoKuIRl2JJsfQdphC
         TOMZnoer+1/Qo0swBJjF1mrZ7EPo3OityBNrp5z7kC3m1s445WT/JdEGzBHhXptRo/Ag
         lLnSWdFKfeMoZJXv9W0l4jQTN5BXE5aiJ5wtcjikAWl5v/hmV89JpzZzv75An03h2vuO
         8Nw57fiCimV9Bo/ndWV+mNe9Mw/6hjcQ2I1zfONAIq0WkWAfVDh1R9i9G5L051ERCZ8w
         ppWw==
X-Gm-Message-State: AOJu0YwPrKGYB7D8KC73gaYmLLsN6tknuvZVA+unu8aHay2T0m6LKm7v
	lwfmCQk+OaHMd3OP5KQ7mQ43GT1tXZQ897nP5BXeYWMT4gVvJp+5OnC1gCbeJg8AUPyZ49tvRM8
	csFswSwB9zzDjKHvp+nd8duC6rOnPbn1IXPQ=
X-Gm-Gg: AR+sD13By1L+jBETs4Jc82Lm1XC8VmWD+40oQI/MatHGJliE6dZunaT6U8eexpUHAtj
	7NoJRA0ggqYNrS4Yrsl79aSt8xGYESYak1FB9qhlUwdQlSDuSTpwJw0z8plUSAP5fE2dIj2/jNF
	QMQzZXtSbbkwTDFaLzqEWKSfz8HGTXxVusXsXQhaPByIFDEUkaFY89PZEdBq4vA/PduVJSJVM/W
	2G1VcVOMZ8VuavFhGGQ2KP09vkszUeJu3jNH4nTXS3g3CPrtp6+cevRhDxYithThE3jwKK0atrM
	LlgJJarh2o564ag1yjLt/5NowUy1UJAWqtzLodOK5vI=
X-Received: by 2002:a53:d059:0:20b0:667:dc83:f75b with SMTP id
 956f58d0204a3-669454a6328mr955430d50.48.1785496328844; Fri, 31 Jul 2026
 04:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stef Bon <stefbon@gmail.com>
Date: Fri, 31 Jul 2026 13:11:56 +0200
X-Gm-Features: AUfX_myLKlSpRbGX8IeWPPgwTiQuy1SH7pCL3zZXtPmmcowNjrx5bowxJbOlGnY
Message-ID: <CANXojcw-ZpHshxUmWPQXtSVZpdU=Pegyq=2JJ34kfKYuUFcqGw@mail.gmail.com>
Subject: Some concerns about recent FUSE ops.
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I have worked with FUSE for many years now, especially network filesystems.

I've got a growing concern about the recent growth of the FUSE flags
and options.
In my opinion there are some options which should or go into
userspace, or are only to be used in niches.

For example the FUSE_NO_OPEN en FUSE_NO_OPENDIR bits. Are there any
use cases? I doubt there are.

Is FUSE_READIR_PLUS_AUTO really required? I doubt it. If you are
creating a FUSE fs, you know at INIT what the fs needs and is able to,
so the automatic thing is not required.

Is FUSE_HANDLE_KILLPRIV just bogus, and was not really thought
through? Since there is
FUSE_HANDLE_KILLPRIV_V2.

Are FUSE_NO_EXPORT_SUPPORT really necessary? Since there is FUSE_EXPORT_SUPPORT.

FUSE_OVER_IO_URING is technically a challenge, but does not offer
extra functionality. When the  FUSE service is doing io_ring to get IO
going, that is very possible, but it should use them in combination
with the normal read and write (and notify) callbacks.
In my vision you do IO_URING on the backend, not on the waiting client (==VFS).

FUSE_REQUEST_TIMEOUT is really not required. I've written FUSE fs;s
using a timeout,
and when expired/timeout, an error is sent to the VFS (ETIMEDOUT) and
it is all handled as it should.

Please think about it, I'm concerned, and worried that at this pace we
just need another set of 32 bits of options in a year or so.
And maybe I've written here something you totally do not agree with.
Ok, let's discuss.

Stef Bon
The Netherlands
