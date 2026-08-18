Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F05379EC6
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082705; cv=none; b=rNAv/TJKlbSGRN7Nq/xJgs1LR2CLIRFDhn/vQlGfLOIUVKExZMNS+rorKWMqwF5iAUr6HkSdNdho7NDniczqrEP/auUyZcVIutPY/VlBDixl3rVplebZEdzKhqFiOoEQmVpKvxKWfjJedQaQJ4YHhB1mkmSaL449so1vTIdvdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082705; c=relaxed/simple;
	bh=BYfEHJfZZMUNLO+ETDGvPO3wLBH8V/4ZmUWO04VYbxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nGzLbYn45sQwdXHlj13mx4+oXEuFUU01Nz7k8LIwTDFWRoNgmdWWF7zxcVP1MEHlF9OsndDl1XZI94oBV2N3/QUfBR+zPxFoxAj74RJsq12qj9oA1/3UjsLJghExrl6oJi1q0tIEThFvHycDwH79DhweCG4/PoN63gJ5+U7aPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPJ4vAIo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPJ4vAIo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso2865e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787082701; x=1787687501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmdtIP0DQL+ZaR3puek57DJtEuSE2eL0MrttwPIizEE=;
        b=mPJ4vAIoDWLoef0MRIcVh/FDvSCYdLoNsdp/Y8dQs7NzpMT7sCHvL0u4aOP6+eJaGl
         5Z6GbwzXIA3f+46nOrpIMCdAx0XEJ7i1RlrUR9Cb8JdLTgIU1u4oeGHBk2KReQ3Krf2N
         nxwDgbeaQlM6EurYvXbfx8+WbnBN2meCmgYZ2wAviddNYZMIEfsCVVlQn+nxEALUssdV
         8BwSZcTFJCpldCbIlQNcxl78Jp801k6LBsZfqVW2TR0W1rLZ9qmKuEoRPOPfK6QutIG/
         FUWD/HMCIXC1dOZtiYlBr7Ui1GpBcXGOpeZJJF9D7nl+DPKphz8a2HQsXLsu3hlxiVhi
         JTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082701; x=1787687501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmdtIP0DQL+ZaR3puek57DJtEuSE2eL0MrttwPIizEE=;
        b=pVlPsAL5ONMv/qLMViVy+c39xckwaqVhYp46Kj/8b8oP1KAY2HtUofDJfAMhBN0ipp
         8iE0k8tjzUwqDHKuIa2lgqk1hACFw6wRYKALWe/tg8cJXnxsZht1C6ra7yFU+C8CAG6i
         e7qQRALRyY+C4zpUFt7PNJ2n98xgqsjX8QT+492/JykijDjUHn8+U0BztEVde6MduBPf
         eRFPrFJdjzIMdqK/ggbm1Ivu8w8Gt8pKS5mAYwMIBk9RqaFx8kUkrQe9hbPbhU0J3MLY
         Vs4YJULSis/nvzbgeiEohqxgM4VIZg/c+ZJNUrwUvDW/VLpd2TNReUbCu44kIYQAvYLJ
         MVsw==
X-Forwarded-Encrypted: i=1; AHgh+RqoNew7cnrUbIkGZ6CPsMUwvI5iILqq5xkr1dIXS6oYFFA3nxJi8qXBLYHi6DjzQVQUkHn/qu1N6SfdZeCY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7n/S+vOjxDrbfcnjNLiJFvWhLDfFkEx7RzTYkVNs+zNRLvHs3
	mfWyY5gQFGns05U5FexBB7hHr4OZT/B+VzFDX6z5F+wsHnXFV2b0HLHVNH3KJkPLHg==
X-Gm-Gg: AR+sD11SKJAaWIViGHVPgcCeEfocTNokPi/thElt+IxWrhkWBxXeImGE725Hmo3PQbl
	big5jMO2mET3w16QecBDz47qsAhN9GY9pR2n9K1ljrsRpv4AKIFIm61kFVYLu/2fa49QZ7DKONq
	3A0gkBkxFfrqFJIv9NmWxwypumrZyGL2KtH/LNyGiVWEr39cP1BVthvTuWlouPJk2YIGldsvxl/
	z8x1G9JXJjnPGRfPs+owCqUMmj4cawxXYN+LF7ImYOJlZXmIzvO/mVji7UmuSCeWQ7Yc3DL6Poj
	aSaPtebNqjDkvc5xf8UE992uJ4bUcgO8sBYJkA/2R/soMdW8yc3IvugPGVqX3dOmKxDPIr4E+Wn
	ai6BFELzFLMD58doSvCbRFsxlQkNKzj2dMFORjIbcO7WxfPBmo/MxXVLSfILidrPIlNHfptgeMA
	GjKsIh+RXT8rHUR3oacAaqvv0dORHNRgevblpFlyjIz5CMP0BxB4h7TnFghhCs2sIq135hvagj2
	O1q3SHBQbdaKk4GLoucPslCwLrpo5KP/Y3G1VLsVTwBkKNk
X-Received: by 2002:a05:600c:254:b0:499:7da3:dd0c with SMTP id 5b1f17b1804b1-499a94ed422mr57655e9.0.1787082700662;
        Tue, 18 Aug 2026 12:51:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:f466:5a15:1301:318d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b2e9sm14732299f8f.9.2026.08.18.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:51:39 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 18 Aug 2026 21:51:05 +0200
Subject: [PATCH 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-selinux-pokemem-v1-1-90cd2357ee05@google.com>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
In-Reply-To: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787082693; l=2363;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=BYfEHJfZZMUNLO+ETDGvPO3wLBH8V/4ZmUWO04VYbxA=;
 b=UL8/Zxd/s6hlj2bjotDfABJon3uluPe9T2bOof/l5Q1BRt9GWXgZ1QNoe2vEfEOairzDzs3Fn
 M5W4YEachE0DIfsnfKkYw38AHvxyEcD+oMJ0Su/fE/5rFJp6s/kS3fm
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Refactor the handlers for proc_mem_operations to use the new struct
mem_private as ->private_data, rather than directly storing an mm_struct*
in ->private_data.

This is in preparation for adding more state in mem_private in the next
commit.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 780f81259052..bec6197329dc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -848,11 +848,24 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 	return 0;
 }
 
+/* private_data for proc_mem_operations */
+struct mem_private {
+	struct mm_struct *mm;
+};
+
 static int mem_open(struct inode *inode, struct file *file)
 {
+	struct mem_private *priv __free(kfree) = kmalloc_obj(struct mem_private);
+
+	if (!priv)
+		return -ENOMEM;
 	if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
 		return -EINVAL;
-	return __mem_open(inode, file, PTRACE_MODE_ATTACH);
+	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
+	if (IS_ERR_OR_NULL(priv->mm))
+		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	file->private_data = no_free_ptr(priv);
+	return 0;
 }
 
 static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
@@ -880,7 +893,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 static ssize_t mem_rw(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos, int write)
 {
-	struct mm_struct *mm = file->private_data;
+	struct mem_private *priv = file->private_data;
+	struct mm_struct *mm = priv->mm;
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
@@ -970,12 +984,21 @@ static int mem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int mem_release_with_private(struct inode *inode, struct file *file)
+{
+	struct mem_private *priv = file->private_data;
+
+	mmdrop(priv->mm);
+	kfree(priv);
+	return 0;
+}
+
 static const struct file_operations proc_mem_operations = {
 	.llseek		= mem_lseek,
 	.read		= mem_read,
 	.write		= mem_write,
 	.open		= mem_open,
-	.release	= mem_release,
+	.release	= mem_release_with_private,
 	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
 

-- 
2.55.0.737.g08866a6d13-goog

