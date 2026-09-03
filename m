Received: from mta1.migadu.com (out-6.mta1.migadu.com [95.215.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C53C988D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416057; cv=none; b=SucU/KQHDf7lEMBk9xN3j8qKnRmoaaxLm7qyaAlqd9worDuVUhJewT+HKzK/amNqNh+2KIq3IhAbaEgmSk/URDrRWNNvVQAicH7bSOOzvjF3rDqB9BvrlvUg5cMXvjfQ26B62qmVSEs+NMQAtpYttIi1a5yu5gMW3otOocubim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416057; c=relaxed/simple;
	bh=1YMLmtHW/WBurfyOKTLaWe5Z6KGqYrkDEKTmr8il+MU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CuGRf0ukENEnLXz6bNpAkdWmQiHJEi0PrgxTfvtTy+f90nOi7X7IbJ9eYBt6DGAba3egt8hz5+QLQkDLsp8qrtzyWT4Ca50Q+S+VUjGFGAlg7bAY9O+OM2vLAMChNQ52+1rIu6tmJbStIErmhgDPqjexbhmFox0D90Gf2ZL82CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ovTain7M; arc=none smtp.client-ip=95.215.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ovTain7M"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1YMLmtHW/WBurfyOKTLaWe5Z6KGqYrkDEKTmr8il+MU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788416053; v=1; x=1789020853;
 b=ovTain7Mi79FQ3AoY/EUs6Bi9nNhzMvf0Oz4u3Y7EE+shBWvdeoEs3EJbRfmawe1fewepsV9
 W5nGohx5uPpFrgtuDzz6We0EL/Gduk0zI+D9PEf+nLbpmuPHYaRp5Y+z2TE3SjYB8ZttK5kvocg
 6af5DK/oxxgZNDFPsg4+YnLk=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 36b16760ce6668a2;
	Thu, 03 Sep 2026 06:14:13 +0000
X-Mizu-Trace-ID: 36b16760ce6668a2
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] fs/dax: Remove redundant deferred list initialization
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260903050207.7015-1-kaitao.cheng@linux.dev>
Date: Thu, 3 Sep 2026 14:13:55 +0800
Cc: Dan Williams <djbw@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <3D5079CF-6FB3-4ABC-A164-D42920A19DA7@linux.dev>
References: <20260903050207.7015-1-kaitao.cheng@linux.dev>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 3, 2026, at 13:02, Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
> 
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> prep_compound_page() calls prep_compound_head(), which initializes
> folio->_deferred_list for compound folios with an order greater than one.
> Therefore, dax_folio_init() initializes the list twice for large DAX
> folios.
> 
> Remove the redundant initialization from dax_folio_init(). This leaves
> the behavior unchanged and keeps compound folio initialization
> centralized in prep_compound_head().
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

