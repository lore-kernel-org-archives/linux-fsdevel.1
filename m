Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67E2F8E98;
	Mon, 12 Oct 2026 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791784999; cv=none; b=oqfAn0W00xzc/CwPD/Zv5En5eqbxI3fBXvCMH9tVdsW0tNp4nhoT9YExjUQsOFCAgVeKJBYzPf0AE7bY2vUJxW+2lkXZqceISzHzhQnRZBX36SmyKM1b2RUN9WTR93QYza6ng7cYLfp8yaznelc45H1s6LHQm8JHIiKAcpF8O8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791784999; c=relaxed/simple;
	bh=e/TewaTiF6EcG1AXZE9pKEnPUE8+0RLucAw4agDXg3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+6R0E8DpSotjmlkSn9o+NKlYtjcQt4h+Ldu6IePO+RsmW4Ub5erNhvCH607s6cF6DN6F24ecFk3CTdwxfAvowJ0xyvYIPP70Agcyql0ZULJmaH3px7fIKZOQ4L3D/CifRmCZ5qfuIi70SfqbMfT5KeHmyzl456wSdUWIvN66js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=2dHLSujQ; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=I2rRky5g; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="2dHLSujQ";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="I2rRky5g"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 6567726F7696;
	Mon, 12 Oct 2026 15:03:15 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1791784995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojyM3xGEEUOo4/eDYFDRNDtXOfSKRPG0G206rrYc4Ss=;
	b=2dHLSujQ/Un2/NS5bh+87y1lPSKQjQA7O6CDWRKwL4J/+s/OXqeNypyeuM9cFG+rw8X7gO
	+NUgQBRp2kAoIuezAN45Z5UoZ8Ud95TAX05WOug+hQRYH75JzbU2HqMzSUfQr7uPtop+Xg
	yJD076qTYWpiOCO4pSNEmwV/51P4rsOUiKqmCOrA52qc1jDCEpn6XPlha9RVUqp3D9+U+r
	pfHn0m1cBhAN83EmHsjcCuoDZS7ItquyA/rblzr15q4MT9aFiJiLtAGhpSQTjGaNP4T+PH
	kf7BWj/4eQR3ZdS4nU7KUFDI0VUwaM9w6aVZBzy1F4DQ2IE3tc0J5EsRZoWi6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1791784995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojyM3xGEEUOo4/eDYFDRNDtXOfSKRPG0G206rrYc4Ss=;
	b=I2rRky5gBen1MJKvxp+76hb2Rq4fe1hEF3HSeQxsSxkTRZRZYFYnWWRtWt5e1SG43Gh3ap
	6WYm8GgS2xavCIBg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id C78F1E001C4;
	Mon, 12 Oct 2026 15:03:14 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id B039022000BB; Mon, 12 Oct 2026 15:03:14 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fat: return only first cluster when allocating
In-Reply-To: <3b610d3340eaa7c22bb1dd95b1ee9b95@inf.ufrgs.br>
References: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
	<20261008020941.55784-3-matheus.aalmeida@inf.ufrgs.br>
	<87zewkkqtu.fsf@mail.parknet.co.jp>
	<3b610d3340eaa7c22bb1dd95b1ee9b95@inf.ufrgs.br>
Date: Mon, 12 Oct 2026 15:03:14 +0900
Message-ID: <87o6czlal9.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> Em 2026-10-11 15:57, OGAWA Hirofumi escreveu:
>> Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>> 
>>> fat_alloc_clusters() returns every allocated cluster number in an array.
>>> For larger allocations, like growing a file, this array would need to be
>>> very large.
>>> 
>>> Make fat_alloc_clusters() return only the first allocated cluster in the
>>> chain. Update fat_add_new_entries() to follow the chain when it needs
>>> the second cluster.
>> 
>> This would be more common case than fallocate(), so penalize this part
>> would not be good.
>> 
>> Thanks.
>
> That makes sense.
>
> I can change the approach so that fat_alloc_clusters() and the directory
> entry path are left unchanged. For fat_add_clusters(), I would add a
> separate fat_alloc_chain() helper which allocates the whole chain but
> only returns the first cluster.
>
> Would that approach be preferable?

Sounds good if both share the almost all codes.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
