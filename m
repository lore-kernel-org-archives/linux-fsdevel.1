Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A23B6368;
	Sun, 17 May 2026 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027909; cv=none; b=DqukRaqBGQihyyKQCs1mpIOefDINcHgGBq838eymdRWEhhXH/22HZmM44GpaOOf5xlH3ompc/v9H34U2sMwSgUNlmT/ocSAZdxdBba4NBJPIMnHNqgXEL6eXrwVUGIWK9v2HC8qSiCoktBVNZBTNjKK8Kha7fHRDkmXV5hPEYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027909; c=relaxed/simple;
	bh=U+oix9J6mb/0JFUGhMT+y34iygXFcWRO7nG/mfLZWiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type; b=SyXORkFtcq42y/C2la/LPNh8vvP53DYY7Si7Q1DA4pWnrU05d+nR1rtgs+NmHKrdZ9P0ijPEDBPItggxrf/LaUl2RqaKP6egjgYnpbeZqVQmLQ/j7ITCZk5PooGdRpMroktw4e4wvu/q1zYuw91OChFVO8ehQiEKY71yuxM5Wdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=hkitd4fd; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="hkitd4fd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:MIME-Version:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=U+oix9J6mb/0JFUGhMT+y34iygXFcWRO7nG/mfLZWiI=; b=hkitd4fdK0QwXn4M4Ufx6FP6p2
	So+kOfeY+7k4DQ+en/TKZRSb+WCtIwMm5uHJ2YEue9gxm5I5c12X2d6UcaGBUPIpme97oVAJkxcTa
	bbWAcC5lPUPBs260GrNtKQZu5+LdRQIJQ0TEpj/ZQQND0n2juylCjmu0TeZPBKQixGH9LFT4gtg1N
	sTE172j2FJ9Ju6VZb9DLd1A26erIeYtjpvk2ExqOeeVeFgEsTTmLZPle0QrNCX1+L2H3+tNjoT99x
	c7sTboL2CeiAsqs2Ip2m6IpsYfoQD9WHRUT/iubznpk1rVjLQ9f0wvLUKB+SC7mR0/ar1HwzhWKsZ
	LMKPoWnA==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wOcQH-00GCAQ-2q;
	Sun, 17 May 2026 14:24:54 +0000
Date: Sun, 17 May 2026 16:24:48 +0200
From: Berkant Koc <me@berkoc.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 Greg KH <gregkh@linuxfoundation.org>,
 security@kernel.org,
 Joanne Koong <joannelkoong@gmail.com>,
 fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fuse: io-uring: clear ent->fuse_req in commit_fetch error path
In-Reply-To: <3f1567cf-218e-405b-be7f-e9e9c44205d6@bsbernd.com>
References: <20260517-fuse-uaf-cover@berkoc.com>
 <20260517-fuse-uaf-patch1@berkoc.com>
 <3f1567cf-218e-405b-be7f-e9e9c44205d6@bsbernd.com>
Message-ID: <20260517-fuse-uaf-patch1-withdraw@berkoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On 2026-05-17 16:11, Bernd Schubert wrote:
> We already had a security report for that on Friday [...] I had
> already replied to Zhenghang on Friday, I don't think it is enough.
> [...] valid all over the copy operation (fuse_uring_prepare_send())

Thanks for the context. P1 is a duplicate of Zhenghang's Friday report,
please consider it withdrawn.

You are right that clearing ent->fuse_req only in the commit_fetch error
path is not sufficient. The same window is reachable across the whole
copy path in fuse_uring_prepare_send(), so a single-point clear leaves
the race open on the other exits. I will not push a v2 for this one and
leave the scope call to you.

P2 ([PATCH 2/2] serialize ring teardown and per-ent setup against
ent->state writers) is a separate path: ent->state being written without
the queue lock while teardown frees the ring. If that overlaps with what
you are looking at today, I will hold off on P2 as well. If it is out of
scope for your work, a short note is enough and I will keep tracking it
independently.

KASAN config and the repro harness (qemu + libfuse uring example with
abort-on-mount) are set up here, happy to test your fix once it is on
the list.

Thanks,
Berkant
