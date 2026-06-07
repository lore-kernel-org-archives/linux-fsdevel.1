Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B878C9C;
	Sun,  7 Jun 2026 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826528; cv=none; b=YhBbS6R0oL1Pnm3Dv8n+IIdHeRlSdosgBUlB+WP4/cv70Rkc0UAJlntEaF6W63jz9/7TQhtdW81MJjIRFIyZ3vRiSoggbd0EauTmrXlcowT1wgQtqU/gDnYXAUkPyp5dcH+b488ksi5WHGaZ6xdtg5EgJkJ65ff4LaioqyN13cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826528; c=relaxed/simple;
	bh=bipTQkn4p1MP/1SyE5UFCgLwsyCGmogZgGboOdqOo6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Message-ID:
	 Date; b=VwC2qMsF9XjzCxl+yN01e5mv6etkml2Z30c4WNGj6lYGiQX5CrEj9i5l3A7rA+OmaGJu1/gkCg8ySN48NUBogzdXuPVNRfyAVOA5f3ChrL9KFE/omH+SrUJI+GmhHObrLXgyIWOGEOtfOnxvJKye5wisJfZqoxQgp1ZFAFXyGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=TEhVJH7q; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=eGsOv1k2; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="TEhVJH7q";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="eGsOv1k2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Date:Message-ID:Content-Type:References:In-Reply-To:Subject:Cc:To:
	From:Sender:Reply-To:MIME-Version:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bipTQkn4p1MP/1SyE5UFCgLwsyCGmogZgGboOdqOo6A=; b=TEhVJH7q8DnNVPdywjZnnxdtYd
	x382/SkqV26I9QmhEUcJHv8rbtTCV21n9uVtJEEEgUsoW7daVwdeucTVOQHpvhc5FiBattS9NHT8A
	2FCIL7GIhfZqg31lqY9wKqDGKGYkTQs0C1mkNiyivbKpSTHWFVDz5Fi5nMRb9hpOJNl+9CwdbsX81
	ApcpfnNIt/k0PRpkQS8IMXR4XQLcweoYtgO7sbh7kOO4GNNR2rwQ0j7y2JKlk1edJatpl3NQGnacC
	7ce4AmJS1VfVAuUN07Jcjq88AKsdB5NXJ60HUcIWJijUjwAmd3uiZSDzmwfoxzXCX0GHZKq9P4Elu
	mBPqBOeA==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wWAKA-00GyE8-1q;
	Sun, 07 Jun 2026 10:01:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1780826454; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=bipTQkn4p1MP/1SyE5UFCgLwsyCGmogZgGboOdqOo6A=;
 b=eGsOv1k2jpJNcmqu0epn0IvmX6hm9ta9lY6OSUCAPdEVH9sz3wIswep1Bu9DisZdlLWbq
 gKcSALlTMny5X07Zarq+gsnV7E9psV0/1q4uPxeUb0MH/jgwC/DwlpCtMdIXosGypSEscf3
 7kaBwowJNcKqvWt/MS731ifcpuKJpxtWNwYG2Eat6DiYTNnamOUsMoguIJrS75De8pladQG
 dTTUee/dxjU0ah9zTRkiL07BdRaZobRLHKJlXCnHIx9fdNewq1k4ZJWavMbrnu8tbxlr7rL
 eH/2cNH+lHIuX/oaLZtJpvk2Q8kQHhOVYp0+XyVTy9vv65VZDkVPpZrSf8iQ==
From: Berkant Koc <me@berkoc.com>
To: Bernd Schubert <bschubert@ddn.com>,
 Joanne Koong <joannelkoong@gmail.com>,
 Shuvam Pandey <shuvampandey1@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>,
 Zhenghang Xiao <kipreyyy@gmail.com>
Subject: Re: [PATCH] fuse: {io-uring} use request cleanup helper on commit
 setup failure
In-Reply-To: <d486fde6-c78d-4a78-8dbd-43b8afaa90cd@ddn.com>
References: <178059213410.15421.10567268398539539875@gmail.com>
 <CAJnrk1YH_SC9doHp60Vuajc-mzQiopPExMPQVVDtFHzB8vTM6Q@mail.gmail.com>
 <d486fde6-c78d-4a78-8dbd-43b8afaa90cd@ddn.com>
Content-Type: text/plain; charset=UTF-8
Message-ID: <178082645430.1952267.3613935151307581690@berkoc.com>
Date: Sun, 07 Jun 2026 12:00:54 +0200
X-Spam-Score: -0.2 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Thu, 4 Jun 2026 19:36:15 +0200, Bernd Schubert wrote:
> Out of interest, did you see the entire series I had submitted?

Yes, I went through the full v3 series, thanks for picking these up.
My standalone "use request cleanup helper" change is covered by 3/4
and 4/4, so I will drop it rather than carry a duplicate.

I still have the reproducer that surfaced the commit_fetch and
async_stop_queues races. Once v3 settles I will run it against the
series and follow up with a Tested-by if it holds.

Thanks,
Berkant
