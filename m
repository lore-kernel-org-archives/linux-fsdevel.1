Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1A2550D5;
	Sun, 17 May 2026 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779026910; cv=none; b=D7rv+szr6WDHMtfEXhUCQfmrKdR2/Br1dOZDoboQhGgxuEbpHmM+swXgHMu1dkVz93vjV/cFpFYnFeLACsUBO/xYQ/CQR9Acei/UE8fe6kIb8MFwAunq0wYxfZwqjeoDjFc0JA8RT5oMi5UIKjchWPPfYxHsT80JLSiPAZDfzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779026910; c=relaxed/simple;
	bh=5lMVbtZqodRVPfMOMhEBRM2oTdv3l2e/W4B5fuECFPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADPjKTbMuLxk6mvg/wK8iXK31aUfJSM9/Nb8eqRrkTbLj9QXNiaiOhsSuSImEvzHMhMCqPc8Hcs+a5cvRG61ehnugYv1vp1gJvnMj5u3a5hvSs8YYuDK7hQ4guKDmna6JdarBUYIXmRTKhBjDxsRN1xbs3y+lJiNhTv8Pa6LZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=oT8lv+HV; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="oT8lv+HV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5lMVbtZqodRVPfMOMhEBRM2oTdv3l2e/W4B5fuECFPk=; b=oT8lv+HVsUgmioP6nVi5IzgBEW
	Dp/YobyymbcmkEjDI3OE2RKCchYwlV6+LjFuIO6dlV31gkK7ljpO0J9r0/47RV7ihYjAw6Vh5wqOr
	94y4RVgL4urU1UgvWfW0dsXsKsVbRk8JH2cXhJi/Z7/K+Srd3ofz7+LjzZqOzAAqX6jIn1Y8VxkwF
	v6QhpOv4z3tCDXLUeENlld/2y0YrEKJ/CodTyQmkzUNtFDrvb7yBO0wPk/uuKWcivRL0aeoc8drCr
	1Dxn3z1lnY3t0zrp3h3HwB5hb4E8yP5x5okgppeQBoa6E/AhlKxulZX31D/hqLBYTYyLZqubEOYZC
	1jZIp0Pw==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wOcAI-00HENh-2u;
	Sun, 17 May 2026 14:08:23 +0000
From: Berkant Koc <me@berkoc.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Greg KH <gregkh@linuxfoundation.org>, security@kernel.org, Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 0/2] fuse: io-uring: fix two UAFs in dev_uring.c teardown
Date: Sun, 17 May 2026 16:02:00 +0200
Message-ID: <20260517-fuse-uaf-bernd-ack@berkoc.com>
In-Reply-To: <08523a14-61f6-4d88-8523-d12c7a5edfa2@bsbernd.com>
References: <20260517095846.fuse-iouring-uaf.dc5f5dbb71dc@berkoc.com>
 <20260517-fuse-uaf-greg-reply@berkoc.com>
 <20260517-fuse-uaf-cover@berkoc.com>
 <20260517-fuse-uaf-routing-fix@berkoc.com>
 <08523a14-61f6-4d88-8523-d12c7a5edfa2@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com

Thanks Bernd, adding fuse-devel@lists.linux.dev to Cc now so this
subthread lands in the right archive. Will use that as the FUSE
mailing list going forward.

Berkant
