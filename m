Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC42221FB6
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804256; cv=none; b=EmO76OlTWERRlXMSV3BmpLaRHZkVpDh8nfU6iMcHrzNOm5aiEZNXoLRBOY8nCVNRA8WYG3UAiXbh5Xe4KD1d8Dd/KinrwibwySu6GCFHOvDMGMFB0JA4LQvXGzKz36vqBOQBR7E91VwDvhdXZ6z+RdQvylNA7OOl3dd+f5xVcTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804256; c=relaxed/simple;
	bh=smjs8DCyHfbFtnAez6SHJxIJ7dx3xNvndyjA/twe110=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=aBZ9oyrJ0jmhbfa8ebV5za6LhToPGdHQqD23aFGrd/kACoKAk6oI2BEJhTWMc+093kiVG1tmEEbAOH/8cHAgZNWhtHKNfLuZhEyABiXbrNN/gW/EodRz8Nkg+e5mDMa6vIDY4qz1aqkyVPyF7tn+ZT+3WNndIaYPIH8462OI76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FnijOR15; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnijOR15"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d70d8839f0so4100715ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 21:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787804254; x=1788409054; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMzSnQkFDbxeGZvlQrOG0uCcN7FgBdb2z4Q3uWVyr9M=;
        b=FnijOR15de8xnGMMz9pC33NWmORboHDsD/CYSQ5U/4pjJZMYBt58ATZYnCXudnDxHr
         2DI9mHwZw06VR219RFnIKiG4MJO6NL7aJR5BbZR/c3iWTvte1bZyVxQsnBqE0YHEhyPW
         ri/w6+TNzar+d6PV4Dx36p8Y8KnmErpKhOWQflfoIDYyUvuaQPnzRw6bQT+PsDVwYdfr
         akfuagbc+BwCFdJh5FGpganFQrUfujOaP4vwuywyXLjtamuO/fIGYfuZ4burXLA+ZOUE
         2pbY9dzdrr4s1dYbYKrYqDN75FgTSxRdj30LLeB/5wLkpVJJt/f6WHr2XJP1LQVpOYQ4
         a+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787804254; x=1788409054;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMzSnQkFDbxeGZvlQrOG0uCcN7FgBdb2z4Q3uWVyr9M=;
        b=Y6G6FUzzZ+7U5XDpDrmqe/4bwrG5hYxAaZlIfgGE+JDqFSmcvm2kEFgx+TmrLEpCTY
         D4UP3OVvNs0KODM6zOA/6ML2cc/eWVxo5/OsX4biJvYSaOxAEvUE2T8DwMdP1PyDr1mm
         lJAKMCqCAiFiMRT6UzS1WOVOWqRRV/oy30zjdfdm1HG4MPvfHjuWXiz5woFYZmof7K47
         Npb9V+Tpt/6Rr/Vh4fR8YD6I8XLtoLpfXsNCoKNkgmkSEh5TzyXWdYQlLWHEIjQAW795
         QkFZCqWOaO0ImlXbxoZt7ozPYTP3aGVlVeYbflDtr853h529VAJEmHbig7KmT4SC6Ltm
         o8Cg==
X-Forwarded-Encrypted: i=1; AHgh+RojlcfMeMv5/fyvDMJdVUaFGhRwZdxUFFYE10k//4UACemLnrKCu/qmRH0qez8G2AoqsiOU0u6oV5509stX@vger.kernel.org
X-Gm-Message-State: AFuF++nsLa6hPahTDKrRhLddHtDbNj4JpiB3p14p1unAeAqUpop18CGp
	bKDFKkSKS8AM+RgPsqGxeiL9Zk0atuzVVYLgLSngRM4aifYjqAMwSU7kRkPgr3B+A1kFgeaaM72
	6
X-Received: from plpn6.prod.google.com ([2002:a17:902:9686:b0:2d0:d8a:3ad7])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c48:b0:2d7:f0:896b
 with SMTP id d9443c01a7336-2d707b9cc1emr247925545ad.13.1787804253664; Wed, 26
 Aug 2026 21:17:33 -0700 (PDT)
Date: Thu, 27 Aug 2026 04:17:29 +0000
In-Reply-To: <20260810204118.1981755-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827041732.188707-1-morbo@google.com>
Subject: [PATCH v3 1/2] vfs: Annotate struct fdtable's fd field with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
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

Assisted-by: Gemini:3.1-pro-preview
Signed-off-by: Bill Wendling <morbo@google.com>
---
v3 - Add version to the PATCH subject line
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: codemender-patching+linux@google.com
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
2.55.0.897.gb25b4bd76c-goog

