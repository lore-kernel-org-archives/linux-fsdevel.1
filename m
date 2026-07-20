Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1872D8796
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581368; cv=none; b=oRrXyMsvMP8CWfSdO0F/cnK2zgjFLfKRJSzRZZ3/mChmuGUJoJ6GL66ZlnQ+u3bfMY8VrD8IWT6SHESrc2eJB4fHCdDC0uBqANnmEfydiMsOcu5Jjmxcs1J28hPacYzxcDgdGO5jVFJOK/gANG6pyc8+hyLTdRDh5CPhz936cCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581368; c=relaxed/simple;
	bh=bAIl0EYJtqhiY+G9Xwxws/qkXqkeERtNBUa0GVKm6tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SduF6e9glhR4/mf1cSTMIzu+NXO9ZXuCo6xvjH82qWQTCX0l+RWs3h3YTiKC+iXoDUVK0n3cy/T14iGZBU2KqrK8NX1u7r8aLQrb5XZXndfXV0rX/LMkvdpVW4P9KJtdccVAzi688HRAzhS+f0iPmxJhWvRixsVD/9og9ZfNvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7FzsCnA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7FzsCnA"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so7772203a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581366; x=1785186166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2JkSd7oYJPFcviDB7E5uYmo6tGTEnQPMBBxrAZJVXw=;
        b=E7FzsCnAlHtLlyCagvDLp/U8FAyFO2PGY8mbaVpHUPm4gVQFldzK8WSK/6xQAlUqMQ
         RZ0P7+LNLXKTIsbe9GGDJJwep7u4Z5S787i/fA5kRdpsrH7uBBThJWlswDrgWaWJWnB1
         8y6hOCW4sK+FrqRyabZBt/49LsUDTx664xaCzU/5F8RWCKGxb/MLqXyJ0ew++SOy19qw
         WpsD5C9brSchSlhlea5/YUD5R8GMwS8iu0KhV5MPIcp7SLKSEL87e8XgrbQqydoHxeDT
         NupLy8AWSS/w3yROETsfiYjfz4P5Te60Av/p66wcDeiszmb/DT1ah1kcgyrheZBdneMi
         KJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581366; x=1785186166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2JkSd7oYJPFcviDB7E5uYmo6tGTEnQPMBBxrAZJVXw=;
        b=PrFQCR2oSyy8BTJRMAxA/q/IcKhpeU60c4pjUaC+F9FwP8HJaeMGn7z7RFN/qRhQxW
         riodPAdnfWuWxewAnE8z6o7n1KQKsVZUMQUHUdETU8FrM2ApH8DbbgNB0rEuk2aRSI7j
         NbVL7gE4R9G7xLhVQAuoS8YjjDwJHq1NUZG9r3ouUna8HR/FxJXbCXD6Q1ZyAuF4k2xv
         lGmD1GDT5LX+bTrTc4dHh/pdSr11fhmm7RA96+MZtxUlD92e5A4R2XQ1fIkuZkwJKFlV
         5z3D6RY9/IqulXhLNm9Rwk09V7sjCUqbrfVsuSD8dvMsX+N/NSrFVzg3DNmml1D48+Gf
         2zdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq56yCsxYs4RPegdtZhvq2SMD4KYN9Oa0PbHZkcZdjKDVjP1xCEHd4SWYfVvXlKqwboB+rG0Mlzwq0HrwDk@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3oTgXNznbccN/TJXyegAcGvy5tK/ZPF5ER3YpjDFkFY4pk/X
	7rDbdwnP1Gx7e0LkbF1N2/670/eqJ8TgcG/XTfk+PK0r9WbEXGNK1CyJ
X-Gm-Gg: AfdE7cmu731uzorFVw5wVK7mZiXf17I7NW4VJOMMXyYHLR0KHholmz4X5XsDcNrzULY
	0oxQMSO4F/NaeE4NSETmYK9V4FSQ1ZVVL+IOOP+j4kL0RJBBtvAYMUl9qLNwBnK0llfCDmMjv4P
	feMyexcVygFfXjdkcs+iMMn1lwjBDrBG1CnZKUcFg8hz0ALIVfmyfYw8crUTNyf4cL9DciZ5Vp8
	4CHdKj35Bscrk9Rk3IMTd4AQ2dRzO5JaZfUECHPeXnUmrh9ftyYbPa95MZ5AxVe1ju5Bku1DHPK
	Vyz7bRIuE8duvNJ91YS6fQ5h6ZwrW64p77aZwsFv8yNYAN1MuHVnnnc+CFzFXuTfiioSF00LFG2
	efxfhiBtpB9uNc1zbCOdeObA0E2kgt/Eb3NY1bcB6e+q7tUIQR59AdfW0shYDENnxsjBctlwjXe
	x456EEU948gYmIucEpI0ZldGrEPdgbE4FQMTVeizh15be1QwpJWiKDG6kDYR6uQhE=
X-Received: by 2002:a05:6a21:4c85:b0:3c3:859b:c20c with SMTP id adf61e73a8af0-3c3ad668209mr17081070637.15.1784581366659;
        Mon, 20 Jul 2026 14:02:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de3437sm4927552a12.28.2026.07.20.14.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 15/20] hpfs: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:57 -0700
Message-ID: <20260720210202.1163861-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert hpfs iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/hpfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 29e876705369..6a629ab956fc 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -156,8 +156,10 @@ static int hpfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(hpfs_iomap_next, hpfs_iomap_begin);
+
 static const struct iomap_ops hpfs_iomap_ops = {
-	.iomap_begin		= hpfs_iomap_begin,
+	.iomap_next		= hpfs_iomap_next,
 };
 
 static int hpfs_read_folio(struct file *file, struct folio *folio)
-- 
2.52.0

