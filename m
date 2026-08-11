Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD93B27D1;
	Tue, 11 Aug 2026 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462069; cv=none; b=Z38yJ7TuomAnTCjeR5Y79Cjo4CHl/b5klldBsHo3MIhl5u9+xtBRHSxXlTG38VilOmu1GIlxh8cq8DF0CoJUN1tbZOt76DRPeNrZQIdi/3T0fe8ippp5Sc0vIdlYg3OcuUD0g1YlvybYepwFd0kmrZ6L/YXXGkvW4uUjuHyobo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462069; c=relaxed/simple;
	bh=SpbEtOACwAfhrvnTo3HVdvq33xeffDHxwIh3irpBTA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZnp5x90/aJWUXf8kaWuCCp+I1d/38E9A0ur2G9UnD6EZ4dl0WU9011y5tOAxNE5GJwKN9A1BahVJSWj1eqz8wkC81otOIATR23+os9qN0UDm7JXH0WJQXdhSjgCbGa1bf8vtCI6tXaUA1ijH4S405214FRECFJxsB19t/nAxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7buYwgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7buYwgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711681F00A3D;
	Tue, 11 Aug 2026 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462067;
	bh=X0X4qAQGOj4Ws5+MdwykOepn652tQT1tcVQqlter/BI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=e7buYwgUaziBc1ANvD2UI/ojDa/PK9hy0xEryGVTXt6hhAv7BxZr0pk6eXRo0lUW5
	 H9sZllbu01qd/GbMN5wZ33oz87qkFzZ1py+pMuA0BLhmM/YI/Y3RHrBrj96nzs//4r
	 tddLT9TnZLRlv7mEEKH9BI1kOiCWw9TOljnV7zOi20v+29vzVrK62DpFJzoNmYpVIB
	 9o8B79PymbbumxLEcysFVZWMb3grWg5R8xsmCG/IhpRQeQ7sglY3a4/vq/CY1wkdL+
	 HHB/NrYicMzwPdAmIEUZTTby0tNrYO7SRCl204XN/Jtfk+cVR9EtxNaZpeh4aFUzsC
	 Eb3CalwVNeCoA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Aug 2026 17:27:24 +0200
Subject: [PATCH 03/11] coredump: pin the protocol struct sizes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-work-coredump-sparse-v1-3-cd3e8b1e356d@kernel.org>
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
In-Reply-To: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
To: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SpbEtOACwAfhrvnTo3HVdvq33xeffDHxwIh3irpBTA8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRV2yfsmr3WqlU8LPaH6vTjssqJdXo/M2eXLTouF8eXW
 Rt102ZbRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES+JDP8MxP6V1N1ZL7jwuMa
 ltxbn3vKHWFcHCyzaEKda7fdOkn1x4wMbS+mtx8/v+HX7U4+hR3Vr7wZIlMn8D7/Gxb10aR7V+1
 GJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

COREDUMP_REQ_SIZE_VER0 and COREDUMP_ACK_SIZE_VER0 define the initial
struct sizes.

Assert that both published sizes still match their structs, next to the
assert the coredump marks already have. While at it fix the "currently
know" typo in the doc.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                 | 2 ++
 include/uapi/linux/coredump.h | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index e68a76ff92a3..235b54484107 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -752,6 +752,8 @@ static inline bool coredump_sock_send(struct file *file, struct coredump_req *re
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

