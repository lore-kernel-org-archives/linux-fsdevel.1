Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E123E3C7A;
	Wed, 19 Aug 2026 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181035; cv=none; b=q7z4OdJIJPYsjYbProNynC5iC+df9PPT3ae7xe/Apl+54CZvj69G+4JKbB+a89Dn/cy+tKCCt679vSeV/1/WBUfvCE+vAEGG7XkRI7qhVZUwzxtOrBEgOuWqXcbi4zkOmlzafk+UDP6uSPQMUaOC0oTxNiV7opsmnyfNbaNnA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181035; c=relaxed/simple;
	bh=hNfZLj4wkqR4WNDayaZ8RfIqHIoYlqBK8NeplKQdya8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqpOWGH+kIQrXZu6FecA0Z5Yh2C1qj8/y+KEzTcBTPih6sIbIm3UqlStVACecO0TYiXa0V/DLvZC1xid50FqV6bENbYGj9L/i53Amr/l62RaoUBxwsBQTMxQBC4r0P7Uvvj4gtSgpCJ33PlG8uzZqzLuMeQgofPFka84O9xSISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aheTWAgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aheTWAgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781B71F00A3A;
	Wed, 19 Aug 2026 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181034;
	bh=fv8QyTU4RY8EKIZbQbAauqSD2AILso9hb2wl7UK1viQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aheTWAgbYI11sVETqvJK2lIN/QCtKk+jUTksr8d38BZ1G7LXn5ciJU2kV1FMfrtmE
	 x5Nnq5XYF01D52VOCaFlhDDagPSgLf9ydeEXG3GKOAegFGirsAEQjyZMqmBVaqlSwI
	 pMwAwjK2lfA2z4C2jvG+KW1viiMGa5Sao32Hs3etES+osbUfbaYKUfkHjbsNwJnxAi
	 i3AtybIxeJJE8yvuUcmJNRePJL+PQ7fBmXoSEKynClLfVT3MSCErW7T8lCghlChbMP
	 tXhBq+ZxGanb0v3pCy6LWkCR8ljc2M14p/psUqtZ+tN63jM9P5d7T7xF9Alu0yONal
	 4itgWc3EmpRiQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:24 +0200
Subject: [PATCH v2 07/22] coredump: pin the protocol struct sizes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-7-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hNfZLj4wkqR4WNDayaZ8RfIqHIoYlqBK8NeplKQdya8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+ruPdQcu/KV3delZuzLP6zVCXY77RHyZG1qzuUp
 7bbKjst6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI6nWMDKdaPMNPTbgbYhLi
 tExpbXfZXqfH7+b3BPyeeS3zD8esc7cZ/rvKPeP89C9O42WYhdi3Scq7956uZNLizXY+om1dYc9
 Swg4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

COREDUMP_REQ_SIZE_VER0 and COREDUMP_ACK_SIZE_VER0 define the initial
struct sizes.

Assert that both published sizes still match their structs. While at it
fix some issues with docs.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                 | 2 ++
 include/uapi/linux/coredump.h | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 24a6405ea242..c696b46c97ff 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -759,6 +759,8 @@ static inline bool coredump_sock_send(struct file *file, struct coredump_req *re
 	return ret == sizeof(*req);
 }
 
+static_assert(sizeof(struct coredump_req) == COREDUMP_REQ_SIZE_VER0);
+static_assert(sizeof(struct coredump_ack) == COREDUMP_ACK_SIZE_VER0);
 static_assert(sizeof(enum coredump_mark) == sizeof(__u32));
 
 static inline bool coredump_sock_mark(struct file *file, enum coredump_mark mark)
diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
index dc3789b78af0..662e0468da6e 100644
--- a/include/uapi/linux/coredump.h
+++ b/include/uapi/linux/coredump.h
@@ -30,11 +30,11 @@ enum {
  * member is set to the size of struct coredump_req and provides a hint
  * to userspace how much data can be read. Userspace may use MSG_PEEK to
  * peek the size of struct coredump_req and then choose to consume it in
- * one go. Userspace may also simply read a COREDUMP_ACK_SIZE_VER0
+ * one go. Userspace may also simply read a COREDUMP_REQ_SIZE_VER0
  * request. If the size the kernel sends is larger userspace simply
  * discards any remaining data.
  *
- * The coredump_req->mask member is set to the currently know features.
+ * The coredump_req->mask member is set to the currently known features.
  * Userspace may only set coredump_ack->mask to the bits raised by the
  * kernel in coredump_req->mask.
  *

-- 
2.53.0

