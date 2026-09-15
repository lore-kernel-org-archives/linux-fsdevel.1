Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED423FB7E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490280; cv=none; b=Em4tzD2bVV6ZcgoFQdd3w8MTPnqxCsChUVG5zPi7UFRCzWOQvZ1Ze67hgjjHTWLm87NDI4BGQHzXdE61HcEuEd0cihTbnVeIacAFxhSG0ElYFUWMj6EqU8qPv9UkNf2V6ecxm/EVVFTj82rJKTw82L9nztcvq+FjuFdb9qrbAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490280; c=relaxed/simple;
	bh=KPKPGF5qsUQqYvKCR/MMxXPy5D1ntqEEj0Sa7swQ5r8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E2LGkBRexNytTiUK5yjyuDiT5qU32nGY8y6l+vmZRpqf0Riru42wYeDJRIr9DUfAzZgIK0XfiPArbtddVP+feWVadcKBmNmx6c0FGqa/7OyWY5Z2sEID7t89y5FI0v4378ZfAyxz3oAT+mq6qRN0MA0cmS3/6lZEjw3xzjcaMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClksJwj9; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClksJwj9"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so1136475f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789490277; x=1790095077; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mP3itgi5VQlf+VGvNzurDARzBqpMd7On/zzuIfwN8vA=;
        b=ClksJwj9NL9O5VrFv1vXx/Av2PseudcXqXs9dmbmj2kCGAaxOnqMZWpwgGBsvU1L/k
         RjvdfE031DE5SJu2pDR0n4n+Me8LhEZ1L5Vvo5ENieEMDV2BpcTe5AZynDer0iPH7hCE
         6o1iUd6+NSB1H+VQoS9y+eYPBjWRlpmMMnj8LeTfxFnjlv/uSqp6ZN1F2eLTLRtkGbvR
         YTb5/QgkIgh3tZiDBzOA1MeT0vYBKrwAB3qTXBz9eYHmMi5o+arN8Jcf5ufHanQpeOdJ
         OzqForr+4dC/dKkNtGwRPaTvoJnW0vEXWxzgfPD8lsXWVPIPwlOavQtSF+iF03VY2I2N
         RJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789490277; x=1790095077;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mP3itgi5VQlf+VGvNzurDARzBqpMd7On/zzuIfwN8vA=;
        b=MPdiznMVJPrDfwJ3i+Aom3WESRy4CI4VDzK0eyR91JwirWgM6Za9iAyTBVKThWhXsQ
         dgpfACXe9YVfpLryrT2ddZJUO1ApDFovb3uc/9mxXNZB75UARtV8ynXXQKkH+eHijX85
         TT8Aeg+CO6XZ6NhP3f6GWMN46qEUOT/l57DBXrmLqW8RcpIy7sBW+I/ErqO+JqC4dA1u
         WeHcRXuMePHH1r/pPQxDzQVQ8wbbORv5gYAmhrPYP/LwZSUHlJWwyaSwGw+Ou43FZSiN
         2iZpllP2afwliTQ9b+gtADzb+Mvw1rTedP/SXF8H43IK6SfuUaO+KK0amEpp24aYeHLK
         x+2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzCqJ2KctWfv35hZoobq9XGOAzGuNFSLYxCdpPWUhwJtK0u3ZSrWtoSA+dswMF5kA7dsO2a0MZnh63+FyXg@vger.kernel.org
X-Gm-Message-State: AFuF++mUetdN3UGPyhxPdmXiL6VdIc+o4AloQlMl1jFJugbC/HmPUBbv
	x7kNzYmKRHj6lUiNVc+C+AsEgVRd3av+jhG4GNsmm/bQxt1OH6xfGhIl
X-Gm-Gg: AYBFou3ebNNw4Iv/ipS+ro2+EgcIVJwmHQZf36F+RxwJ9s9pIlA94BN7EmMSWtH11YK
	0bRrYFP36mrPovNgKuRXaqwUSDNXiXw1TQqv9W3gCfLFg0FCAezHIVrQEpbf+yK8i2v5N8u32h7
	TUKIxzJpz5MVeOljx8D+iWUz0U7UFy+S2a88vqi+pXk1PDZFIWkbP6gX/eyux7lPm3RZfHvoH/W
	bGeRZu93mAbfu519OJMgvaA1qqse3geTjtPY4SSMiLAfCTBf9yLh0myeDsl9IOwsKbuXdKhg0sc
	CyFgb1Q14qC43LuzgYQGUEphM6Q1YPIVkaXUmIqW+Al2+zLkDp7od2/+49NtVFHXjVzDgOBI7pc
	FMdiYsad6A5/r6e57gZfWeszIFDAwm6gwZCHxcm8NCQLNi9iLUsnj8rMzymibISkH9DW7QGjwjz
	TKqtrm2WcU6dt/i1vfaRAt8Fc6XEF++pCg7zxTUs1GjjgUQW/8kHNaxvqIgfxYvMLzSzsHeQVfZ
	+XCPQ==
X-Received: by 2002:a5d:64ee:0:b0:487:342:eb37 with SMTP id ffacd0b85a97d-48705a44316mr6723385f8f.7.1789490277250;
        Tue, 15 Sep 2026 09:37:57 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf34440sm233295f8f.25.2026.09.15.09.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:37:56 -0700 (PDT)
Date: Tue, 15 Sep 2026 19:37:53 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] vfs: clean up indenting in lookup_open()
Message-ID: <aql0YTgwtRI0VZyG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These lines are indented too far.  Delete a tab.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 fs/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1dd4ec7d0e62..48b28ed44a9e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4636,9 +4636,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (create_dir) {
 		struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry,
 						       mode, &delegated_inode);
-			error = PTR_ERR_OR_ZERO(res);
-			if (!error)
-				dentry = res;
+		error = PTR_ERR_OR_ZERO(res);
+		if (!error)
+			dentry = res;
 	} else {
 		error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
 	}
-- 
2.53.0

