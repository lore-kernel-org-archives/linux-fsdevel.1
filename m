Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28E2475E3
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Sep 2026 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573862; cv=none; b=KCQQ86l+x7s1cHaHOp/WVzIKur/mqbQRCNaXJTcNVJXpVKif81U1NoG+onmVFStmFPD4ni+uKhDshw3wWxNv757hBAZQD37ve9MH1ZMcVcFeJr5sW8qiKBnLZOVw0z6Tehm7Ra/WXiXW8OrWxd1PzYVc0rNQaPgCC2tI35V/Hjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573862; c=relaxed/simple;
	bh=pFlkzUEF60hjvvZPlBwEViqf9LW3hv/ZDP3p8UY7P6Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lFPsZw3WPa4ogJ4Uc29rV0pHHENOvOg8lpC0059EBezo9aylDSXG3kkayOqNwlwkjm93V6nbHPMRcd15/wPzcmFEKmxG8Sod0/orP0Gzgt1Tt+ZM0JO0Ynf3nn9GcqoGcFwxMO5cWthBMmVQPxJDR3oAVnd8juQKnoVlGXma5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NhdGgrz8; arc=none smtp.client-ip=95.215.58.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NhdGgrz8"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pFlkzUEF60hjvvZPlBwEViqf9LW3hv/ZDP3p8UY7P6Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788573858; v=1; x=1789178658;
 b=NhdGgrz8C6PveTSJhAycpE4OiZCh4F6j3BAvgzO8LUQRn6NsxdpWjvCdhvr+xcWuoN22g9aJ
 9MkfmC5pataiJkKn1kT/nFl/gmSt3xZgrt/CbbJ/hWkCyaT2zgOXl/CuLJT8xjIanOrGj2/LiJZ
 kkvjpJ3unskmigrqjAorve7A=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 3a559c3ce0b8e0ea;
	Sat, 05 Sep 2026 02:04:18 +0000
X-Mizu-Trace-ID: 3a559c3ce0b8e0ea
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 2/2] fs/dax: Make dax_layout_busy_page_range() static
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260904152749.84493-3-kaitao.cheng@linux.dev>
Date: Sat, 5 Sep 2026 10:04:00 +0800
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Dan Williams <djbw@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <293B2E4D-DB53-43D6-9AE3-7EC1453A13E2@linux.dev>
References: <20260904152749.84493-1-kaitao.cheng@linux.dev>
 <20260904152749.84493-3-kaitao.cheng@linux.dev>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 4, 2026, at 23:27, Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
> 
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> dax_layout_busy_page_range() no longer has callers outside fs/dax.c.
> Keeping the range helper exported unnecessarily exposes a low-level
> implementation detail.
> 
> Make the helper static and remove its export and header definitions.
> 
> Also fix the stale dax_layout_busy_page_range() comment to match the
> implementation.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

