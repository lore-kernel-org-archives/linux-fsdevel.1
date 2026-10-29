Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268044;
	b=lj3cJBSqt+Qhbjjm4qQHMu44RS/xC23FDlpK++69EAaenhYdaDavXEpmF3UW0/RDbw8a
	 EThH241CroKG2mM7xzVN6ucIAuB4h8JImKORHq4gay4rVLaEjEftUFkw+UtIJQL1VTzLx
	 x6OCo77+FMSp5qzBVQb7tMZ9qexj/XVAhkrZQFpjeGluBU44uCDbEg193aHAupAIJ5WAt
	 hKEejYFVdWOPPxtJSb8mrTT54KCcmAq9y884bDUy4ARPRUnjTOJ191MpQbWr4xcTRYPrL
	 F8ngz6JFZsZdiStyWzl/3GIAApQQb5krkxe56aVU9ClhOEDL8kf5GKKzq4tWiYs3+nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NvDQgFPrYIv0RGOIRNSHY0lOqUOFb7lap39i5lWlHGI=;
	b=SbfzPOkBPhdrQ10qNWCjFSpm1VfCdiaeUqqxzpHVbtXNyjZo4o3JjS7tRlxycIq5lBlk
	 8IBLZUF5lP2yNaFsDQOsCVWTeGB2JNq+SvSKj4NyFgHjpG4exhXRRzXvpi5PToI4PtCV+
	 vuUdoxXt8nSv4/rpoEENZ9mraK/cgL2FLETCAx/Q3oEvZxIFJcTSqmVBIYOouXCF0yg2x
	 qcsJJUjqdbdjfhA90SZmyjadCKgrxpIKbQuaZlq1Km3mYPjr/Kz4iCtyzeEG9qQ+NE3IH
	 /3rjK05e/FoSQR3al/dM0kutCXV2bOx1ApA4fEeY7zdNf8qT7qr2iUJpApZzLs7L/DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNFACqP8;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B74D60A261D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B74D60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNFACqP8
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so1133551f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268043; x=1793872843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NvDQgFPrYIv0RGOIRNSHY0lOqUOFb7lap39i5lWlHGI=;
        b=nNFACqP8iH14vZfcni9/+w+f+fwBLOpoZaFcjOLzlKZ0Lc6v6A6ssBwaRpFxnSnbvQ
         ZoRa+MAPqZ3FZcjxzkUja8ZDRtyVYD6tZfr9AEvR6zZ5m7Q+bogw8lq8ZGmBgj0tMJ9x
         HxT9Dpah7EuFtNNvHKjLwEpLoBfLLGJtYMlplYy8lb/zPpHCly4atpF+jH6kdzenzDQ9
         1cF/fW9U92z/5V7r9zFTj5FDnzWS2CWzjd0gICjAnU/wIIp0jERODOj91pWvNcLOO05d
         qJuKYlTLkxtu5pY5uRRljRDcnDx4Zb9SlS5SaDWMvc5rI1XeK0QIUcR6wLbhfNvz99n3
         glPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268043; x=1793872843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NvDQgFPrYIv0RGOIRNSHY0lOqUOFb7lap39i5lWlHGI=;
        b=IomGeQJlNREhHbX20uNg60PaGg9YtD7IdYp3fxereO77LaGC5DzRRr1IZLYIoLSdXi
         Gzjvz9auag6nF+85PPT4R/Z1BjxfRn5MMxPivLkKr0QUGzl3lXasRymIMrAqlFM3og1A
         LHTJaAUKC4afhg+6HtqyDZLRveXWO0Um7fjcBCuy6fJVJZgpipBKTroV0BsgJl0SF/d/
         IUapyu+DAHoClWq7YAJCeakFQy75owiZC4HELKPsH73pI4kL9eeyCLvib0Kt7/Cf2dbC
         gla2tP6PurXrx1AIuv+Ibk/5SdX2ztOWY+n3OUnO48kkiHnEB7jGCRx0/Wp677uxyQu1
         Yy6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzGzKsXbzEFh8DcfZGtIPrx8OhrgTBMJNnxKISGWf7aWG/rXId3C+f13z4fv/Ei3pJ7m6TZN/p9+q032Bq5@vger.kernel.org
X-Gm-Message-State: AFq9FYLvGN0B1TOvrYGxpHeisPF8rwBdlH4lleYti/b349pkT1YRyo/c
	17CVIb/P0uiXaBTPWg4xmL0RXnL+w+aDpRUcEG4wJ4LYdGeGoEElKoed
X-Gm-Gg: AYBFou00Wv+8krMjMv8pw+oSiPRcK55FOfpBzB0XHCPuIr3ZYDe7svuDEWEit581cCM
	WzxVumdMpJT1bkNz/TjBOuDWGoGgVx3UcUZG4dOoX9xnu6rhD1DE3E03rTQshEgxE29j14Eqeft
	GlSeZ9zHzoZegHukV8LS28ozhKU92QB8sUeviRxB6hDbEVT70HKI8FceyYQKoCwcq5v/Guhfq3T
	Cl+ockwded4pOcJyCMUjQIpBUl/x7LhuroBsEp/P5Gq0fH+ZF4zcOD3MrSsNXB+Y+wHSuuWEDFY
	6rA0N3gpNC7GGTguMcYaGgFv8D4fJezuWCcIecZTKfE9jfX533i08IdW45xMvoStREhmUupI02L
	dHvX/Lkq27bQLtaEz97dhJFRRnKlCrG85/yJ2K0Rz3dUjH9B4osVeuZnmp/pKKh5GB1BWQpflHD
	VJ0vi+M3xPHidbEmCRzQUSJIYvI3+JIKY2Sg4uF/lp5pGwJTjqlFhrQRFe02eRdW857WxNgKdBg
	lngG4ectTN2ruUVa2GDCz1ukJ4UDboAQPpeXVUKpKHtJiGIG3ggA7KTzIDk7Am/mJl69Np3DOta
	sl82XqWSCVQQeEcI98xUzs+6gPGr519sSoHnwzrS1f+SefHwhMfzVbamP7cugc98
X-Received: by 2002:a5d:4e46:0:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-48e5d58f60cmr9225873f8f.14.1793268042831;
        Thu, 29 Oct 2026 03:00:42 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm34025569f8f.9.2026.10.29.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:00:40 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 2/3] docs/bpf: Document bpf_path_getattr()
Date: Thu, 29 Oct 2026 11:59:51 +0200
Message-ID: <20261029095952.44833-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
References: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
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

Describe the interface, result fields, supported flags, and calling
requirements.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 Documentation/bpf/fs_kfuncs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/bpf/fs_kfuncs.rst b/Documentation/bpf/fs_kfuncs.rst
index 8762c3233a3d..9e0e391bc007 100644
--- a/Documentation/bpf/fs_kfuncs.rst
+++ b/Documentation/bpf/fs_kfuncs.rst
@@ -13,9 +13,22 @@ BPF kfuncs can be used to get these data.
 
  * ``bpf_get_fsverity_digest()``
 
+ * ``bpf_path_getattr()``
+
 To avoid recursions, these kfuncs follow the following rules:
 
 1. These kfuncs are only permitted from BPF LSM function.
 2. These kfuncs should not call into other LSM hooks, i.e. security_*(). For
    example, ``bpf_get_file_xattr()`` does not use ``vfs_getxattr()``, because
    the latter calls LSM hook ``security_inode_getxattr``.
+
+File attributes
+===============
+
+``bpf_path_getattr()`` queries filesystem attributes with statx(2) semantics,
+including overlayfs inode and device identity. Use a trusted hook argument,
+such as the path in ``lsm.s/inode_getattr`` or ``&file->f_path`` in
+``lsm.s/file_open``.
+
+.. kernel-doc:: fs/bpf_fs_kfuncs.c
+   :identifiers: bpf_file_stat bpf_path_getattr
-- 
2.56.0

