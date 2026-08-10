Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A30442B03
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394494; cv=none; b=mZ4XCqeP83om3tzxI5sqYeZogx/3t697bq5egGzL/gVIDGAS6VzEyNEa3o8PkFtPmAZUDkgdFoQGFzHR6InHs0Fce+PEXhmT2mLk3+A7IVG+Sn1b9xVlghQGGyrScJ5bpEm+alaWL3HtrHGdXFNj0OYPzXItn3P637Kajbqcu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394494; c=relaxed/simple;
	bh=pFQD9MFc4A7vMMm3znX2ZQ/fMcPWFpch65waZMmi/CM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=VywhbvhAz0K/tXqXeRNZOXZvfCWPpr4aJwq8G4SFhbl6G72Mfq6FRQUBlgOyFZ1KGFTBX52QE/IwMr+ivgw3N+/DbqhMlSWGSFtJcft5EQkSolzLnIEBBWpbbny0EIc1zHGoPnbV2Oy4jU0qDpphEWQ7xOui3PO6M4xvYjfhpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ix1jsaBp; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ix1jsaBp"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dff6253so2898815ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786394491; x=1786999291; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TEfuVEjGYGEogEAHeBDsRpCxcd7/D4XhwfU+1h+Q/ks=;
        b=ix1jsaBpWEe//RJdvGX7Lyiirw4HtQN2Ym/FEDxpBrxcJAuiRcUddZSSwgnMOLMjDX
         8NJsrlNX71uJ1+d5SORB/KPATmtqow+q1+qkLDITGgHlGCZ4nTi9EI8DaabgxE+Z6TOO
         vw/d03PwXJ18oPJjD/NFZu8TGMR5kWhCzCubGcrOKiMaUTuJJKiPh17Cj41SwwgxMzs4
         pFxIgLDI0raULDzYSYTdxepsQ5REf3icghHcEKXZ29g9/xM7mcU1MUmQecLOgwW47v8Q
         diUTm2KvHwx6RCdHqJ10NnbkDhR0YB3JNjd50HSDmDlUJC1zkO54iI8EY7dZsyp1bYw+
         8wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394491; x=1786999291;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEfuVEjGYGEogEAHeBDsRpCxcd7/D4XhwfU+1h+Q/ks=;
        b=qqJIpwfah4NwrLAVnT1ounBy38DrCd5/kkJccRZJKNe9ODc4+IG27RE9gZzLYqBSw2
         ZeA6EpR6gt+hWkAq7zoAyCXzioOnA2X5UdoX4VYg/kkk1OFePxf6IaibQr56HvfWbTje
         xpg3Dg+7BsB6zHz+pMFVz5kn5L4Ecx5GoQbVi0YpRIvV7bjxjmlmQoGxvLrTWPw9m5ao
         SJXSV8VDxitXhGEI8ucA+TqpL/g/bVy03qcfaWL13GwPAKI5quBuSfKQhx6A/RgFj5kk
         KnTxyuYfe0U0Ikltl3zw+biFod6ntYem44yDuwQE3T/MkqIJ6xBsoB5m331D56fE4zU3
         Zyag==
X-Forwarded-Encrypted: i=1; AHgh+RqOp8+YGF76XaiVyHfALKyzcOd9IgBkZh9s1Sc7f07FtyCuftuMArW306dBmkvIbndElGNUkKVyMfbDuq4D@vger.kernel.org
X-Gm-Message-State: AOJu0Yyot7hIBbh+Ba9vStryLVyAUjI88ICxjJ2Cxd43u36EfwEyHhMg
	QIFgvc/smOfQNZSaNLjHE3mGDVHUe9ewWggUOYQAoIhkp+xjKxoizWLeG59Puo3/RiRp6Nuen1X
	s
X-Received: from pjab15.prod.google.com ([2002:a17:90a:100f:b0:381:171e:961c])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0e:b0:390:b3c5:e2c9
 with SMTP id 98e67ed59e1d1-392d61cf225mr489608a91.17.1786394491093; Mon, 10
 Aug 2026 13:41:31 -0700 (PDT)
Date: Mon, 10 Aug 2026 20:41:12 +0000
In-Reply-To: <20260810204118.1981755-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810204118.1981755-2-morbo@google.com>
Subject: [PATCH 1/2] vfs: Annotate struct fdtable's fd field with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The 'struct fdtable' holds the file descriptor table information,
including the current file descriptor array 'fd' and its size 'max_fds'.
To harden the kernel against out-of-bounds accesses, we can annotate the
'fd' pointer field with the '__counted_by_ptr' attribute, referencing
'max_fds'.

The compiler uses the '__counted_by_ptr' attribute to track the
size of the memory allocated for the pointer field, enabling
runtime bounds checks under KASAN and fortified functions. There are
three places where a 'struct fdtable' is initialized, and in all of
them, 'max_fds' is set before the 'fd' pointer is accessed or assigned
in all allocation and initialization places.

No accesses to 'fd' occur before 'max_fds' is set, preventing any
potential runtime false-positives or panics due to uninitialized count
fields.

This patch was generated by CodeMender and checked by submitter.

Cc: codemender-patching+linux@google.com
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 include/linux/fdtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..3a5c88291125 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -25,7 +25,7 @@
 
 struct fdtable {
 	unsigned int max_fds;
-	struct file __rcu **fd;      /* current fd array */
+	struct file __rcu **fd __counted_by_ptr(max_fds);      /* current fd array */
 	unsigned long *close_on_exec;
 	unsigned long *open_fds;
 	unsigned long *full_fds_bits;
-- 
2.55.0.679.g6767b8d81c-goog

