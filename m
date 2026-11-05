Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892260;
	b=ML48zL6nJehP9A0VJdlCqigImIavRClQ9jS4dC3r2Xea8JqzmCWg0kVFgfHtX8O80KmJ
	 DHGnEAU744KYKBs/knTxC0UlIvhLnDVFrCF74RsMljEs0ErfhHLW4q6XjCJM+KEnzw78V
	 +UGjivThHpsy/557W8nueQfnOZF68BrTLWyHPWm3KjjoLi94kxSC09dqOfZrwukBvyk2I
	 cVn8MKNUEHND3JdEtmkwRfvTWZvQKQVA24QgpGf2OJM76Eg3zaY1Y0Z5Z3H6ThSkl3too
	 q4nWZl8LSHmE35kRh4tAwUjmlKph1KVisVatMGH/UGFz3M2l3CrhGaQ4g5j4eozQnuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=CgHGWEb9qpoDk/IyVDhvoOSLBvsdHKyoPKqeM6nD2fs=;
	b=uCwMnzEfVmtCNGRB6Z/85ilOtxN01IBh+4Vk9R4UnwF/mDQMHr4nHYCf2rmfOtLDyExf
	 6ALGoGCzJa7Uz/3DlN7dYSZo6i8tFagPZL7jgtAOkWWkSlQ341V0YIZF6YLoMuQoBCmrD
	 VDx5pyAOtnt782Bch+jxFFPHA2G63EfU67aJh0aPHoX7SsmUiC1EUH30d7afBY+IFlo/Q
	 T5Mj2ND9u4NtOn7IjPG8HqtSLpRB4H+u/gx0vjzSSaHZSy3BNw0+QNQ7ri6aMi4Qqr7c4
	 KOgLW6mpdFQGCIo6UzmmfXDIwjF3yM8LLlRgvgq3aikdgibLDPp5xYLyfhBGco1XLfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=W5OmI2WF;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C2606A33C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 697C2606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=W5OmI2WF
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-945e6d9ceeaso59587285a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892259; x=1794497059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgHGWEb9qpoDk/IyVDhvoOSLBvsdHKyoPKqeM6nD2fs=;
        b=W5OmI2WFoOrlPQaQlqW7y6prTDYzYnz8LXlYBfGdlxGrZzyVtKZmJ/tYcn8cw1ovvD
         4IOeCgsJg2xYdI/Z4xT0aA8AohOBoorIOgSnXak5YKCBU3ReOLfYVYjdx41p7OXBeH+Z
         7we7zHkKc+2judyarmVw/Yz2wj3rNGBoaExaCZqC7+qDS1upN781DJbc22xHgiD6Mgj3
         UGRdmz5SWVNOlMYweKQLRFa92qwjxj1qGPghGwxX7lVh6X1SKYNvXjQqaJaqd0NyGtha
         DWhWH9M4sCrOzXL2XaKNohgNc5OK0KJOkh/t9C0Yxd6oEZQ8DvqPO3EOjzlNHWx2DI8t
         P1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892259; x=1794497059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgHGWEb9qpoDk/IyVDhvoOSLBvsdHKyoPKqeM6nD2fs=;
        b=UUYoq5nkH1lsUGQRJHA0Tp6tFJp0OXIQdlsIKUu5oI0CfsLRTAenmM09dZtA5vRrBg
         V0NN184voYbFPilFMpLW7UJczTlsukFefwc5jwqjDicqzBziEvK5vRKtVkBSVkoS3vEQ
         hbAusi8vcHIWS1PJh5sBMXoNf+kzn/D1PmATzncfHrF5P252SOwhQDCyOdnO8qR4CBWU
         +2u6immDMhr5Hq6OVfuKjQLnqc1e6kjt7fCWglmRaHKw2jS8Vwqdnwkg6zMaegbDnmi3
         bLF3VoRwbhysvyC0g2H/Gg83FelJW+aZFgzdsPSIb9nQN8wd76so5QDrU4H5S+2mppAx
         ogPA==
X-Gm-Message-State: APuU4Z8MokHpZAMF+1TICAA5WOdPLQmWGvm9quJPJMAPZjUQrLQZXOdc
	JUAU6kiPlDEzwJ621lSwpUMUZoZQxi4FgW6TsgAsUpIjcDlt5L2i1rpbNeYWB+WFuOs=
X-Gm-Gg: AYBFou0NWIermUvhN1RFOULduTJU4OMeyzjbM0iE9J59XaxAd+stvZBXTpP4ydIUbuo
	GBqvygKNs3yRAW+PbPHh0rSlpqVCk7ZbpkdYBX0bPp+4I9dohVse4kvap7k6GdsYeZf4gWNxecn
	7E8PFLhGpAYyadLI6c927BOJ+gbYUDPXSgoiUbgkB2f64c+VaPRwx19j9XWN9QGCsmXI3qOE+1H
	+wON7wv6cs9vnGGEt8TNb3tiU8gdr1vCzC8kQpO/g12CXuWgOs08aMqYFWzb08fZ6/WsqgVctww
	+Wz+i5vCTeuLF1UGeS9CQEs+hX/+LLmJs0kmO+bIcC6kU/4byOzJ4dNNCSL3AjUxKL+SlFSl/3i
	syulek4ROxShzqCJchOu/GEUqIZVvn049FTxgQAdmn4jXZ/5CYatn3KLGRxXPEmnEJczdko5vos
	mxE7/c2ssU1VMCbOh9+CoEHUly8xJQ61KU8beU5GobcXOEpscxge5XmqqzcGyuhcYyTtrPJYJXx
	ZeI9DkUXY53/DDYPLJZSXXfg4LyHyzqj/J/XZb8zE6Sj9MLC3wc7kRxs6Z9i8reXMW0PplfQudC
	wwolvFio/q1SixETIhlhhcSlPaW6+9QC2Yqt9gRphwJX
X-Received: by 2002:a05:620a:1d06:b0:93c:7f48:8f46 with SMTP id af79cd13be357-944214d0ce5mr3206665885a.4.1793892259411;
        Thu, 05 Nov 2026 07:24:19 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4799adcsm484751785a.13.2026.11.05.07.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:24:18 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:57 +0000
Subject: [PATCH RFC v3 65/90] capabilities: take nothing from a file in a
 cell
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-65-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=1657;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=D+Cdq2T2lPlQeYvKpvG0Sin8qjhYqa+M0Cqy8B6GRBM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ75FP5at3MtspptwDZZtymvVqWbz3AfoOVYDHJb/KXuaVKmb9XKwBI1faFkJdsgbaOCx4kPANF
 W0BUytw9RGAs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

File capabilities with the effective bit set mark a program that does not
know about capabilities and relies on having them. If one of those
capabilities is missing from the bounding set, the program is not run at
all, and execve() fails with EPERM. This is why ping does not start in a
container that was created with --cap-drop=ALL.

The bounding set of a cell is what the builder named, which is nothing by
default. Every task of a cell also has no_new_privs, so whatever the file
offers is discarded later in the exec anyway. The only effect that reading
the file capabilities can have is to stop the program from running.

Do not read them for a task of a cell, as is already the case for a file
on a nosuid mount. The program runs and gains nothing, which is also what
happens with a set-uid bit in a cell.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index 8af343c78d35..02e25ab18f56 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -777,6 +777,13 @@ static int get_file_caps(struct linux_binprm *bprm, const struct file *file,
 	if (!mnt_may_suid(file->f_path.mnt))
 		return 0;
 
+	/*
+	 * A task of a cell gains nothing from a file, so do not look. A file that
+	 * insists on a capability which is not in the bounding set would not run.
+	 */
+	if (userns_is_cell(bprm->cred->user_ns))
+		return 0;
+
 	/*
 	 * This check is redundant with mnt_may_suid() but is kept to make
 	 * explicit that capability bits are limited to s_user_ns and its

-- 
2.55.0

