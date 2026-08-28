Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18336D4E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909275; cv=none; b=lVb3V7iRM987eF3YnHhSzZsWfUBv+4TU87l+eSMYkxRzGfbUoINd2ZuPHbEd0Fo3bD+6n1SUaEYuHTTK64JxGUl7XxZlLgsKCLOgxNEQefbN1gIV5ivpy+SBhpqdcBmO9ebOujrAf4ZBLV888vIOUNX559rqCQ7ddvCCc46L+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909275; c=relaxed/simple;
	bh=I/vYuKgJLTZRgDTqGS1seT20mT5U0t8GT3h0wImZ8Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+QYZyH9ioI3iPSv1qIBXE9E1jT+EO9AKYxdUsuENvQoCE5+F+L8GW2oesgxYIAh8jMXg9iqIfa6a3rnE563tg62cS722ieAtz7svyrZ8o516zInR+uiIalekRhuWyNrNxjHEj97YEKUWuLhsl07A16rDsx8ARIroNO0uPIaG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niShYthy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niShYthy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d58efc7356so7262135ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787909273; x=1788514073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQoHUJcgX1iG4XupJx9j5w4PxH5rLx3k8eXCcQlCBrE=;
        b=niShYthyCBpeuzWOcV5jTJI7CpqqtPBUndsHPDmZM+xPVKfFpcVxtTe1k9XeOk7zSo
         29t06f7g8dVgZn313/mzZcXp+/MKEnlNcEqK2VTJNrUIRWzVBekPmb92bkuw4789QtX3
         A0fr+K05/BUYTasQ0HECDQebdbN9znZMfUBTQ6THhJnYQOU4zlRkl8P4gVGy39TN/p1m
         gE0LGGl5xw1BFbATrhBuOn2gcsGCB1FYxXLFsAV+KePrbMnX2DeQuRlo6u3qLOq1+f2o
         mA8V3FIJMSvrRLrL6GO5+Tsy77iDD9Qm8dbqLE5voOjPDKdeyY74DWeBEVrX8cUT4cDl
         v5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787909273; x=1788514073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQoHUJcgX1iG4XupJx9j5w4PxH5rLx3k8eXCcQlCBrE=;
        b=M0s+bSPiP1UmlRSS5oQ9t88pzOcvDSvIf7av2UmTGk4dUmcrwjRmba8ey2ZyyqwmyT
         a+g+HIXKZ2Nu3ExNhjJs/jqIphsV5Cc9UjqYUAva4LE9h0lWHxNCk0Q3rYfxHmkCgNql
         TPRJB7+GuRAr8AxxOp3LLr55MjF3YD2TKRS9WkFP6qBRtOpc5XvSmBEOY2fKh0tfaLPP
         Q6GHCdDeVYwP+UlOHQQ8KhYf/kFFMOW8NP2/3kfonY6Nnob8AJ5zvsRKGWWQqrzexFt3
         tpVpv/0LodbOhKc7IEVy/mBJ69fSly43ScQQtzltBOhTaDI6BHtLvFA2UB2JvlN7Cygu
         Ym7Q==
X-Gm-Message-State: AFuF++maXlMlIVfHMSoTa9hBPPbyunqSZ8g3nlG2aPVq04alhssZ/PQr
	Ozdoun3qF0WFzQR9a5Wo1RfBJ7dcNmnpf6g0guX9U1GKI03Gg3LOCOWT
X-Gm-Gg: AR+sD13npLWQtt+0I2Z5QA11ywnYJMcvKIxbQ5kj3yCy6IxZkM1gJO3hBuUPCtWIh7T
	7WzEUIZoybMTPzbfsIAjUnQsnJwIHlegI3w0ff0aHubA2gqPru9PI+31V7QLkyJf8QI3ABF+ug1
	b4itypbxbcFl8qz3VGGhdHc9eeYzpoL6OZrKu42TFLL1gRF18YEq9OGhMozWHHXpw4yn9A+TQ4f
	w2VppEmE3/rEmbGmRVWksDAZnauZBbRTgrE2NEnLg35MbdS+4Al8pwG3MTnVHbIEecaFLoG3Ui7
	amYHmXyedFuthYDFdXzjtGryh/SLYhokPOiEDqWe5sjr98SkWV0eiBwiDxC+i/zKCjcjZm01Yor
	2GxYjjIbAOjEvkZubCy3Zq4sbqk7Fx8IErxk3DlvJqL/fdJw6qBoZnmwv7WMKPtbyDhqVXpcxPO
	ZVn5XRpVQbz9weDcsNki/2Xmvl3gPtyCAETUXYWzqMbo3cpAAgABC1b+lEov3TuweH/ESxWBAJH
	BUqgDceF5Pn7tlkeBKHilLSdsMbJIx3a8gW9Y7n1wT3BQ6nTOU+1WFu25OcbZdw0uOwnKjHr6qg
	h9dzPJ2MXKTHD/Y=
X-Received: by 2002:a17:902:cf4b:b0:2d7:71e:575d with SMTP id d9443c01a7336-2d74df04c8amr111140945ad.9.1787909272886;
        Fri, 28 Aug 2026 02:27:52 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b68esm3680355ad.58.2026.08.28.02.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:27:52 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2] chardev: check return value of kobject_set_name() in __register_chrdev()
Date: Fri, 28 Aug 2026 16:27:34 +0700
Message-ID: <20260828092734.600911-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The kobject_set_name() function can fail and return -ENOMEM if memory
allocation fails.

While all other functions called inside __register_chrdev() are properly
checked for errors, kobject_set_name() was missing this check. Add the
error check for kobject_set_name() and jump to the 'out' label on failure
to maintain consistency and ensure proper error handling.

Found by manual code inspection.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Add Reviewed-by tag from Jan Kara.

 fs/char_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 00229e25c10f..5ce5423f6c99 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -280,7 +280,9 @@ int __register_chrdev(unsigned int major, unsigned int baseminor,
 
 	cdev->owner = fops->owner;
 	cdev->ops = fops;
-	kobject_set_name(&cdev->kobj, "%s", name);
+	err = kobject_set_name(&cdev->kobj, "%s", name);
+	if (err)
+		goto out;
 
 	err = cdev_add(cdev, MKDEV(cd->major, baseminor), count);
 	if (err)
-- 
2.43.0

