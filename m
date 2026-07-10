Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B1344036
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693640; cv=none; b=oKA3YJ6d2zHqreklXKKd3JnGboxOuUhKyh8m65SQERuAxbm/WXO1E7+zZHMPAnQqCCd3FjJf4jPA0XdyiM8u8YIOS4ScqvGuLNHX0D1r57Zm3kxr4sej03bNvke8KG008BuRnRMXeKMPHdDj/Di1+3AaMueKubXVs6z6IC88k2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693640; c=relaxed/simple;
	bh=GAvukyep41tsz0A0h7eblH/Y/nBwYIDwZ4ehkMHwBIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG0Js02+7FcDUHe2RKgoPXMim1ksc4OY5AaCr6pDz5V6Nyiv6U3htcDUHGpMpmoJ81mNEUm0zyslo1Q73x8H+Ra2jxvFfi7qv+4bMxEqDdLHeo/IU3HsCI2SzGzXZmt07ffL4ZXRuVrpYbE/xVoAFGwd6VJB7AvEuezg6khQK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VGzwAx5F; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VGzwAx5F"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783693637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FmCT4DwIHwttEcyHwv/ZZbQpIwis/aYjRLRrseNeWs=;
	b=VGzwAx5F9rA1F82TQ32/LNbqmDdW9MBXQgFlolv3tLjzikFryo+koLfd4e11Ri6RX/fEgh
	1brQBf25j1rYr6dhlXnxihh8ETSbVbLnRofpN7gQktXR2idUV4BRHOEWcxSnpdhtha7tTO
	B/hXuJPOAPB5A/tIaPSHEyDUkdajXiY=
From: Usama Arif <usama.arif@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 01/10] mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
Date: Fri, 10 Jul 2026 07:27:09 -0700
Message-ID: <20260710142710.1067864-1-usama.arif@linux.dev>
In-Reply-To: <20260709184740.1286561-2-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu,  9 Jul 2026 19:47:29 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> This is a better name for this predicate.  Also make the argument const
> to allow other callers to be made const.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I find it nice in review if it says No functional change intended.

Acked-by: Usama Arif <usama.arif@linux.dev>
