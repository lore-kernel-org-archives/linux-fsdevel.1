Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B71DE8AE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364760; cv=none; b=lChadrDOAlqmXF4NN4c0IDrH8AKFvRa7cqCE/2Qhkm0bA5j/W4yA3uDmBy5Iim9feb742pTUrB5AzLKh5v8e9WBbe7sJRnsdYVNCPMiQcLzXy+n/eWbOVCBRWjlqxLHec3yfEp948G36NrC2Z728pwaklpymxJA+ZHEdq3XJXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364760; c=relaxed/simple;
	bh=neup7ICaOgOYLihbLF8y9EsmEBdbODhV2+JM5dvYnW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKJEMllKbWsFV51QAovCd+r1L1sfH2Bh9z+CAFd99cXm5q74TVsmqiFk8NwVmBYxdKyiojcFbBySiEg47m5eLKw0WXgGR+VmB5QhrGO4prJXmw5BdSLgbAdI6tjosGdT+W8kIgBG1hfSx4lTN4w3xw62LsOEaSvcPq9aqEdnHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb6MNGh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb6MNGh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89A51F00A3A;
	Wed,  2 Sep 2026 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364758;
	bh=LSAPbyLSqSH6TLsiRp8716W8HrJRQsQ1E437qtv0vfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Cb6MNGh3vrJWxtyIb5bsIjU78nFCmqse5Pnf6GqPQEgo5+8UVpCW97Ekiqwe/cubj
	 9wpci3rXLMoeMjRSf0lfgKMXGSCz/PCGJRQVAqTWGt5QOMGtABsORWwmmE0tPKADmH
	 YFE96pYQLi8CYHOINCEXdtPl1cNdtg/cS1SAbv9XYYY25Axl4x84OQ5VzV9JuVnzq9
	 SoSc4sOI7cnpZuJxRNzYUP36MpZHywlTkbK3gavrtXcQbPMdJJoi4MGUXKs1zj1oD7
	 EzRQ+oPZjwGvg4jlqTSa0zEqQRohrYtbz+FPP+q3J8cKsr7xRzf/yNinMrcAj43N+i
	 zUE5QKHORk6ng==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:33 +0200
Subject: [PATCH RFC v2 15/16] tools: sync coredump.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-15-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=brauner@kernel.org;
 h=from:subject:message-id; bh=neup7ICaOgOYLihbLF8y9EsmEBdbODhV2+JM5dvYnW0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF/xVyj4+L2be/efOdE/9fFETa+pFy/8y7L6cGhua
 Um8beFm/Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJOBYy/FPbW2RZFclis3R1
 Tbr15bLDYX9XOvapS5RbP+2X31p5/Twjw6VapRNin5lOnahUW7nG4+3cuTtXB+wxf5C7TfZk6G8
 JKQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Sync the headers for the selftests.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/include/uapi/linux/coredump.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/uapi/linux/coredump.h b/tools/include/uapi/linux/coredump.h
index 6d0c53b534ea..ec09d7ab0131 100644
--- a/tools/include/uapi/linux/coredump.h
+++ b/tools/include/uapi/linux/coredump.h
@@ -19,6 +19,9 @@
  * @COREDUMP_MEMORY_TYPES: dump the memory types in
  *                          coredump_ack->memory_types instead of the ones
  *                          the task selected; requires COREDUMP_KERNEL
+ * @COREDUMP_CLOSE_FILES: close all file descriptors of the task before the
+ *                        coredump is generated; incompatible with
+ *                        COREDUMP_REJECT
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
@@ -28,6 +31,7 @@ enum {
 	COREDUMP_RECORDS	= (1ULL << 4),
 	COREDUMP_SPARSE		= (1ULL << 5),
 	COREDUMP_MEMORY_TYPES	= (1ULL << 6),
+	COREDUMP_CLOSE_FILES	= (1ULL << 7),
 };
 
 /**
@@ -137,6 +141,10 @@ enum {
  * Note that @memory_types must be zero if COREDUMP_MEMORY_TYPES isn't
  * raised. COREDUMP_MEMORY_TYPES requires COREDUMP_KERNEL and an ack of
  * at least COREDUMP_ACK_SIZE_VER1 bytes.
+ *
+ * If COREDUMP_CLOSE_FILES is raised in @mask the kernel closes the file
+ * descriptors of the coredumping task before it generates the coredump.
+ * The task ends up with an empty descriptor table.
  */
 struct coredump_ack {
 	__u32 size;

-- 
2.53.0

