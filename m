Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795255716;
	b=mttYg5cE5fcBzJqQrVC1oJN3Dt6cyr2wGvb0nbCugnneFYrH0RDvZI8wiM/Du+2C75aJ
	 8qx8gzy/7E3q5l2FYlv9bZlQKwZdc3YUNUuZA/HUQuFlolEM84jljbFQNxf0+XceipXBt
	 D42amMjGF7a8P1awOeYmDEQT+xuaqon6grEKXjC55yEPfI/MiXwpSSUpw6d+EzOauMFC5
	 aP/BQYNGzdJSEztSDk6jAWQAmwKW7wO6G3kIbijEVZAS5wOaecnWQ+xFO/PeMaHQduy7e
	 69l5czn+CIJV++L25SvRdffjQCKoY0IgqCHZ1yAW1TPsCPGljjyNNZjK5liMrxPjVnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795255716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M3bV9m2HMGmaCwO2iKbHIS6yi+cpxYoMn1NsouoZxXQ=;
	b=k5eq3/lKprPT/lhq8kixiWgwu0acnMNredQmVi6zyC4kElU8Xbo9fhb+2lgQjqbjlv6U
	 fehgWI0kPXBLRZLPHrFa2JHIhm6Y9IYYstKe/BWbsgDy1yV4EmbBvcbp/jxlDXKkVaf1y
	 7UOiiJaFSp1IFwp43fbu8yoJ2Ry0P4j706jDmrwRroEFy4zqnHAIDjHisRfAmVBdzWsZS
	 ql2GoJ5pTAAxgaaqTEk6bcE9xuRRf/jbP/+GE6xT2XWQRePm27JKqHQQElBpAdcCC6Imp
	 JO9u45MWxNOx8p9u/iq1grPwOcnfH3zBU/7NDN4jVQFkHI7Q1fhYnWxK0L4qD75kBkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vIjejmKx;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B243606A320
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 10:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B243606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vIjejmKx
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so13165615e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 02:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795255715; x=1795860515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3bV9m2HMGmaCwO2iKbHIS6yi+cpxYoMn1NsouoZxXQ=;
        b=vIjejmKx+awfWvtxbaiVdjBrjmiWjacQOxqPsZUI0CqGCDW0fuIiZRQXVDudTZGOTR
         gju5da9tDZjUyLhePRxMGltOIhPeBE99/TXalHSZJxFwMd2nSXfj/NxgATCe0LqtdlUl
         zckXDAqUVxmrB6H3i/aAMoJt1OqMT1zQ4QELOVm5EJMHsQHN6XIozmQwDAcFpaTGe1FJ
         kzBgVYJr/RM5r+BgnefB75i+A+nbhCubEQMkKMT+c012le4aDcLPSP1Tv3b/eFsVO8YK
         BrQMgijnUDiONQ99FXmLVxrum8UhLJCHLtkwN18C5zeOB1xqLvThyeguoPisJgItezGP
         A4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795255715; x=1795860515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M3bV9m2HMGmaCwO2iKbHIS6yi+cpxYoMn1NsouoZxXQ=;
        b=jOD+B9M/rGnBRx0vZM1PR1rWH7DJoGMKllgsjRs6nTptHQ6ff9zfeVY3yPGCLtH4mJ
         y4ZkkKXagfonOmk9MpJR/z5cjTJpPcwO8uKYdtmGOMfFoLIwK3soWuUTLcqaiSv7Xk4Z
         cMd+kYg1+y8YsddYm4fu45eHIbyDvUlOeGumV8XF6OkBVQKOwhVMaB9g9+BnqaCjFRX5
         8ZJO58lQkkWXuirl+9m2Dd8cy5Fk1MNbb2uVCWa/fGJ7vvKkq85wHDkxU9/ZK1au+Sze
         GxOb9zcHXG1h4HZQR3Qc2C4nupd7W9UOxHdW+/HCKOGiyvv826K2Zoy2Thpq27uyXDeU
         heTg==
X-Forwarded-Encrypted: i=1; AL+hErGZOaWu3eGKC+XYK3xrrG1pU3PUu9YywghqhS4FwY7/rF4x6oULrRNeFfeVdCrfJBrgS+eZ4edGSilYrJ/C@vger.kernel.org
X-Gm-Message-State: APuU4Z9wcvM2LR7Fw1HMiSKPP+tnOGYERWGIzn92xEE/+opKIajRiTRt
	kt0gv29uT8aTnPxCNe+PlHXD0aMAZW0/RF3IT/LQRwuYc0427D3oB10n
X-Gm-Gg: AZFdTZc91uxNgNgpIqYLsy04cJE88UN5etqJjQwmr1V7nXI1Qay9auxTkthojl66uuZ
	BPCYogrcjmRi4lJF3bUBchkLwRs9wb9C7ToGg3eSIyCzXUh5pidKVsRjReXx4CJLPPMa3b19t/N
	SYxB3qaLfR4pCtPbeulalLBccAfdT5KwGQk20o6gQ8X1/C40zkNNHiiAyLUcgUACjeujQEwkXHS
	WZwH/yHmTQ4Drsp2D21LKra4Uy5BgPlHA95U/oKctynRzwptzsEUf4VZTpfXUl5v8LfKnaKFhQH
	UQoMKgXHgdgk0ugs/n3nZdzs3ng38WM0BJr7H2WScHg99NqCnL5wRYQ9cdDZ3/p95cwhkeFaZuw
	P+hPDV6omT2nMMZewUwvRSyQV2IOKMoDw6BhIE4OhaGgN66KcZobsBKycooVg8iTbUmkcYe2kxe
	ZRQ63mHpfSOpsHlbw50OPZDp0BhKkODelu30ixNI2ijl5nrpGOJBYJVwWhyrBTyxtQMLbqO9hHW
	7vR0ADn1jdZIybenZjcWEnsY5cqqYLYpJsrCxgl3BrOUEoJwBZPpEOhOYWzl7sZfXF1uGvfbJKu
	1pmz52Xv9679gTVqUauCTWKIt6AUeaKlI/g2iQy1/IimW0cTlMUWbo7gwcsO39tCAc3UuHVJRUa
	dtpofsRLF+ZkmnlMdT6tmWIJzcPtH5jbV39zC7gzbMtWc+GYM7AQ=
X-Received: by 2002:a05:600c:3b8a:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4bb8892da25mr128310005e9.22.1795255714723;
        Sat, 21 Nov 2026 02:08:34 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([197.118.31.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906635c7sm44631505e9.2.2026.11.21.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:08:34 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v2] lsm: don't call d_path() when current->fs is NULL
Date: Sat, 21 Nov 2026 11:08:32 +0100
Message-ID: <20261121100832.499-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <481c20b898f003247763475ef417c321@paul-moore.com>
References: <481c20b898f003247763475ef417c321@paul-moore.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Paul,
Thanks for the reply,

>  static void audit_log_lsm_path(ab, inode, path)
>  {
>    if (current->fs)
>      audit_log_d_path(...);
>    else if (inode)
>      audit_log_lsm_inode(ab, inode)
>    else
>      audit_log_format(ab, " path=?");
>  }

I got your intention in your v1's reply, but i think that changes the current behaviour,
if current->fs is not NULL, then this would only log path, without inode, whereas current
code for example here:

case LSM_AUDIT_DATA_PATH: {
	struct inode *inode;

	audit_log_d_path(ab, " path=", &a->u.path);

	inode = d_backing_inode(a->u.path.dentry);
	if (inode) {
		audit_log_format(ab, " dev=");
		audit_log_untrustedstring(ab, inode->i_sb->s_id);
		audit_log_format(ab, " ino=%llu", inode->i_ino);
	}
	break;
}

if path is logged, and most probably also inode, and your suggested change only logs one of them,
Is that intentional, or am i not getting something right?
In either case, i would happily send v3 with suggested change.

Cordially,
