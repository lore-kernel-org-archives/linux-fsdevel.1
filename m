Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312A3A7597
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440876; cv=none; b=G2KhZ1IZ4/SuHXNU5CbpvwtDm8Utu0JqgyAFujPJEu1rcOmcrY6/X9maWdB0avqH7P9PRLOIgAGIPP1mpSLIV4RbBuwMokfKMDpjrbCgd95msZkI+ao2Iu453GF+Nc/MPb92GfZWmxiMbcHzxkUIwKrCae94WMxzniALmy9qHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440876; c=relaxed/simple;
	bh=X+6iZWTfWXpo410W4glUkXVe/Shkkk6QObVykw+rX6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8n32Ckb7i5mo12aGq7QMkGFRsnWZ/Et4EkE+ieHfS8olW5UcCjhT+5FF00uDSzlo2I+n17TVl+PbDD3f4Rm15IqoloSqanC9cYFbqsSRPMkmsJnxqelmGAjU3OJcQI7eRDOYii4DssFLChb+9Uequ5mAFCORvegAqWUL6kLJXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5lBxgVZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5lBxgVZ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so6957103f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440873; x=1781045673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jl73xD6zIPi47mu1jowzc4phm5baQXMI7icQsNN3pI=;
        b=J5lBxgVZtN2FI/ioqwhDNCosN/jZxozQdxLdEv8Lsv6+u08aS7OxTXrQzGg72R791Y
         z32rVB76ykLqfRKHMQDiGLQGAmHWCKGHI7AiNnVW1XWIXiMnT2eX5t7ZtVn5WJ9pzdxr
         bfL67m+3y26zQeyeaJEk577celexSXvREDjuhI0lTlSDWcyIshaKWjaTihfPmJhfCIwd
         MH7OAX39QaAQh41d1ecKqz0qNgVt+7a3qN85DYTIMQaZ2dwdMsWfE0NHmsWsCaSLpamn
         zO79gWY9UqRLT9WZWT2xXwMwr6B588h+pNV2K+1vQX1dtxuAKvd+s0Ou1C9kqMvX0vVP
         NH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440873; x=1781045673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Jl73xD6zIPi47mu1jowzc4phm5baQXMI7icQsNN3pI=;
        b=MixxSLxbkfyfFI19DGYprCrMs+PIo3w15EDMolrvQ122ZvqOGX2ZMgzvH2dFs/eTJu
         SdjzHz2V93NQ0a4NcseIS5SBLoD+oGGgaR9Cq3/dITy4Sb23OFyj50sYDXh8IHBmxC8i
         uomm6X6YEnMG/gIgLovFrHEpX4PPr/xuRNZIaU0psfFPyNqAzGXwYOC9zB9mbaYxrxrZ
         CtnlKkrqL8EjTyvlvSEony+nkpC0IFw2PgiMIixP4lH3ZjoAH9+jw4cUKV28KJBJPd+U
         q1epcoE6968SAMhAMCzEdvGkQWmZC+VexbAwDTPnQkLpRMAroe8fcyQOP/xca6ZwsId9
         x+gA==
X-Forwarded-Encrypted: i=1; AFNElJ/U+YyB7oYt7MjgbZRKxdcm0Fj09b4y7nnTVIUkBYTvkGh8ivzApKUIB/5Rirlkcf4izPduHtgwvIF3fd3u@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxoBJ82CwZPfgLC1fqmqQZzV4ulMnJDbPI6oMWDabEqnaRHEM
	Y6kOxU6Ttjcbi3cnYxs3ZZQX/ql1Y3UfU/6GNkdzIqxRaomu5zFp87fC
X-Gm-Gg: Acq92OGRrJKd9w3GTZVK+w1Ui145P3O4mt3xHX/O/iI5mvh4NRdiUZ1cN5G36Ki6+Y+
	V3wQa65Qx7abJsMB8/Gpa+Z/T3IajxZ7fOel84UPG+CCW2RX7idA5Z76tkDyUbDTsKoZlx44e48
	iOVPInX5RpNOO2JJQFyVqjzWSAoDDVRhJsgfy6pc/uDNZcErrXXX3/FfHVTFZ36c8HK1/HeWbO1
	Tx0LQ+q8IICmxNRuANzMEyuO4tgA0nT3RhNjUVczaI029EXNOToEsTKamsO4xYeh235fGtBroku
	IZI0fj6k52BeUB5+VBwpOB74ZpVL9s4m+XSQHUfATja89jvm4tSETLlZSfVpHootV7EDYRt7zXw
	kvnNrn3quBxEXnEE+Zi6Aac5h/JA93FLsIhnHGK+XPK6N58vsab0D/lEfxVBsvp7+b7GrCzH8eX
	qQ+dM5zJryVvr8OQ8VQWPUqXiiMbUvxlI0hvvcnZ2L
X-Received: by 2002:adf:f58f:0:b0:45d:3cb0:5ab1 with SMTP id ffacd0b85a97d-46021873b26mr407422f8f.38.1780440873290;
        Tue, 02 Jun 2026 15:54:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2dc577sm2550100f8f.3.2026.06.02.15.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 15:54:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed,  3 Jun 2026 01:54:26 +0300
Message-ID: <20260602225426.122258-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus Torvalds <torvalds@linux-foundation.org>:
> That isn't what Askar's patch ever did.
> 
> You apparently didn't even read it.
> 
> Honestly, I think you are the one out of line here.
> 
> Askar did something I suggested years ago, and didn't remove any functionality.
> 
> It just changes vmsplice to be a copying model (one of the directions
> already was). It doesn't change regular splice at all.

Pedro is talking here not about this vmsplice patch, but about
my future hypothetical patch, which will remove splice-pagecache-to-pipe.

Let me clarify, what I want to send: I will make splice-pagecache-to-pipe
be a copy. I. e. this splice direction will continue to work, but will be
possibly slower. I. e. I will do something like this (see end of this email)
(absolutely not tested), and the same thing for other filesystems,
and also I will remove resulting dead code and remove
pipe_buf_operations::confirm (it will likely become unneeded).

If Pedro sends this instead, this will be okay.

diff --git i/fs/ext2/file.c w/fs/ext2/file.c
index d9b1eb34694a..8edcc3769793 100644
--- i/fs/ext2/file.c
+++ w/fs/ext2/file.c
@@ -326,7 +326,7 @@ const struct file_operations ext2_file_operations = {
        .release        = ext2_release_file,
        .fsync          = ext2_fsync,
        .get_unmapped_area = thp_get_unmapped_area,
-       .splice_read    = filemap_splice_read,
+       .splice_read    = copy_splice_read,
        .splice_write   = iter_file_splice_write,
        .setlease       = generic_setlease,
 };

-- 
Askar Safin
