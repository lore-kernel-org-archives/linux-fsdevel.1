Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28162C11FA;
	Mon, 27 Apr 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309103; cv=none; b=CzHgM8TphF0vZOi5dPmeNZ8+pap9neLpYiKsYYgVHaZ0FxEzbODajEXiZlhE1wxVlUiogqNoScwlmMiE0FIvplL5/FcF28l48/XrUU/ougjjMAkd9J6kCGlQFC2Nd0q7IGjIqgKsP0mt6tnRqUQUqDrL/XzGPre4A92J3bA04LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309103; c=relaxed/simple;
	bh=Fqn8R5/UvXsYymxlzmXGD3E0tTLeNOsPCi8D027jsqg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=myg8LoAzCIrCqQuIShGn/jHOkH76AxqODQmgkxENlZZLGl6yQy3aUWUM8khbMFKvrnHh/djDTGsNMecxRnXSpwVUM/1Ih6ysQcZWg4yokYOKUgnkLGydwiJ3zzYhZNHYdLqVoaTMP1i1noHAyx6j1tCLRHJaZ8vobCFuvbdBns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Zont/CG0; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Zont/CG0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777309077; bh=sedt+0yF4PUXjW2cDCOuf6zPYyf6IHuFfjmu5yfXC5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zont/CG0ABOv54t4qVAB9I+1E9JbS2gagH7mZvQ6iNCrAujXTqK+W6rpa+ZPZoah/
	 G/KnvFayhnvJWZ6FLKAPeCpb4oOSbMif5Ks3hrysdlZ8RmTIHbMq5YSNDkReSRI+F0
	 3/CPZXIVVMJGfE1i1QEM3nfm0j7BdoJNhkU0KLQM=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E73AA4C8; Tue, 28 Apr 2026 00:57:51 +0800
X-QQ-mid: xmsmtpt1777309074txsg2bvql
Message-ID: <tencent_6116695C50CF078AB6F36F1E40235E377108@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfiz8Rydv2i7njf9z+f9bbu8zDDCUeFgsDjDbuYchvLoA9hsxoXC
	 ga78Eulp6EMVLvwd21cfoMvhLxpdN9qTNTUq/JzYF5fuClIxCodvNAWQwtZDwJKTS3By+EziMA8s
	 y4Q2q6wTkXmziGRr2Qw1ZQWZX+r1Uo2z99KomAVYQQsjUEh5AUHC2cr/xGZFgMNL45h4ed5JJpvm
	 bdXTXWyZ6ShMMnaKGslzcWphja56fpgGXubtaiXf70qRMgJnQtz9fBOtYIAf++4qtL35uOorMWgA
	 ebVnSgwBCHtduOCvjyt6oo126NhprmRa6HOehNkuPT+BxZppRqSQQHn/pEhyKWa8V2EU0yKDh8hf
	 fJYFbQjLrox/6Nl42nW8DqpkxTy4J5JqpQaA68R2B3B2j1IjauVWtIo7vgheGuuBy1KSwbthIbLh
	 zt9d1RFMrlVzUXm/PCcWRVGfmnHRBnfItltriMJ1CsT0uUCv1nMe+PQsShZhwpciX/s/icayQZUc
	 aX8L3FxfwcJN4+6tbpHJHGk8IfjVb44na/t20hGHy7vJTF/QlFinQK9UC3VinLT4XbJcaF+nhdRv
	 ZfrR6w+tH3T558Xrq7QfyUuCo2/devF87AhJscVtWOI1/soRsqLACsQ0F8NiCxOhJ9G3OrWKTyc8
	 UBX+31NBc3sUEvFblNovKQOJV1AYJH9BjGMmj0PcjjlVFr9/Yu2pjOXuCn7+KIZH94ChwUUzKsJW
	 3ipuYENJjHP3xBTUjS06abhiJrNEM3jl1jBOMJDPR1DDr12yT+mT8kKmWcNLhqnSf5Yel97TqOIo
	 b8qFxMm9i8CFeGydD0Z1nmBJLZ4VhrWmXAwSSmTgGTnm7fdqtiOq5cpuvDTao7rCx6llM53osTJJ
	 o+WnqRk7DDhfyu+iJ15uRvD/kozg9JbMfGrlJC03yL8iZhWTdz7WLGiAakPp6skKfR1oSc3z/3Bd
	 9NelFPg9Yf8Mo3dUu/uQcajPKkGqyEseWRUpEDD85SRJ3BhpglWYCULBZkJHCPCod0ZEQ0J7DfIE
	 MANPAN6ZBDuX3GyNN4Kv/7+CAZH+Y0eAuHwqPpBlQ3G7dpK3Fr
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: fujunjie <fujunjie1@qq.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: [PATCH v2 2/2] mm/filemap: do not count FAULT_FLAG_TRIED retries as mmap hits
Date: Mon, 27 Apr 2026 16:57:51 +0000
X-OQ-MSGID: <20260427165751.746502-3-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427165751.746502-1-fujunjie1@qq.com>
References: <20260427165751.746502-1-fujunjie1@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A fault that starts synchronous mmap readahead can return VM_FAULT_RETRY
after dropping mmap_lock.  The retry may then map the folio brought in
by that same miss.

Do not let this retry decrement mmap_miss.  The retry still maps the
folio from the page cache; it just does not count as a useful mmap
readahead hit.

Signed-off-by: fujunjie <fujunjie1@qq.com>
---
 mm/filemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 41ffe9036c96e..f244886b1df3b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3926,6 +3926,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		ret |= map_ret;
 
 		if ((map_ret & VM_FAULT_NOPAGE) &&
+		    !(vmf->flags & FAULT_FLAG_TRIED) &&
 		    !folio_test_workingset(folio)) {
 			unsigned short mmap_miss;
 
-- 
2.34.1

