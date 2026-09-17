Received: from mx01.bremer-it.com (mx01.bremer-it.com [85.215.132.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B754705C;
	Thu, 17 Sep 2026 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.215.132.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669524; cv=none; b=OIcfJwva8H/iAK2dd6YpdTLGlYiCLipfi69Fcs46cq3etXHDZhqlfQqe7xLWNZbHBQ6NLbjzPEvyg3woanITucD4qnMPdXG1t5LEQadRG+ogIprafFdwDZenSD7WoKxUz7hHVxLbcGv621ZU9EOxZY/PTl7d4S/cG6E5R02C/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669524; c=relaxed/simple;
	bh=sEVn6acemqbDqDRUrltQ7xP6Mhnk6B6XIPfeACjrJOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2FY1w6ZQ4rJzQF/1TnXPzCliEhxvaaVm1QjoPgRnM+CHMn+so//QchpBVhWJnAlE5d2ED/lyzZtXpPfXt3IcvkudOaaERLtzptZFNnWYcgJHArCE2Qx7O1BAaOl27WdLOmmBkpAgRNnc2QhFZhUUkRfRsA7C/WjpZ6jv50U3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barelysecure.org; spf=pass smtp.mailfrom=barelysecure.org; dkim=pass (2048-bit key) header.d=barelysecure.org header.i=@barelysecure.org header.b=Ho2sf6EZ; arc=none smtp.client-ip=85.215.132.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barelysecure.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barelysecure.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barelysecure.org header.i=@barelysecure.org header.b="Ho2sf6EZ"
Received: from cashel.logfs.org (c-98-33-96-243.hsd1.ca.comcast.net [98.33.96.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mx01.bremer-it.com (Postfix) with ESMTPSA id 0924920ACF;
	Thu, 17 Sep 2026 20:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barelysecure.org;
	s=dkim68; t=1789668960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDA2dRaD2XYs4viDCKuQp0KcwdHL+fraeSFF/rd3WCM=;
	b=Ho2sf6EZ0GEmRoN/Lyy36L1qAS8HAezzKWkwIRJZCR/OtOfg99UN84vRrDDaZXijoo9QPo
	mPCpw2r8TICt4Yn3UJNPl7UQEL/sAQ0Tt0tGptIOVIcjE7DRhl+bVX16Sn+LiBppXna+bo
	7azGI8MQR6RCPBM6sUFnRJ7tEB1PsxV2x4LCknC2mihA5l7+53ZR2BN8911Z+htK3pYBwV
	2buMslcwXNpZ8V9fgwOVFz+eb/ZFkCAD9fu+5EfQ5yBlNc08q/9R6+HCkDTBn0LC/gjsCN
	xLpnuNWusBGHN+/x+cgIXg8XInXRzSVVrGMpABwn7G1sR5bYvDmS7+mIOjN4gA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joern@lazybastard.org smtp.mailfrom=joern@barelysecure.org
Date: Thu, 17 Sep 2026 11:15:53 -0700
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@barelysecure.org>
To: Chris Roy <iam@thechris.in>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>,
	dakr@kernel.org, driver-core@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, syzkaller-bugs@googlegroups.com,
	linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, joern@lazybastard.org
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
Message-ID: <aqwuWWMwdIcx3704@cashel.logfs.org>
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
 <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
 <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
 <2026091753-broadness-bootie-b683@gregkh>
 <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
X-Spam-Level: *
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 14.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:7922, ipnet:98.32.0.0/11, country:US];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[7cab6a19619f1b8efc00];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[barelysecure.org:s=dkim68];
	URIBL_BLOCKED(0.00)[c-98-33-96-243.hsd1.ca.comcast.net:rdns];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: server01
X-Rspamd-Queue-Id: 0924920ACF
X-Spamd-Bar: +

On Thu, Sep 17, 2026 at 01:28:22PM +0530, Chris Roy wrote:
>
>  drivers/mtd/devices/block2mtd.c | 118 ++++++++++++++++++++-----
>  1 file changed, 98 insertions(+), 20 deletions(-)
[...]
>  /* Static info about the MTD, used in cleanup_module */
>  static LIST_HEAD(blkmtd_device_list);
> +/* Protects blkmtd_device_list and early-boot paramline updates */
> +static DEFINE_MUTEX(block2mtd_mutex);
> +static struct workqueue_struct *block2mtd_wq;

This is just awful taste.  You are inside a file called "block2mtd".
The prefix to the mutex an workqueue add absolutely nothing.  Calling
them just plain "mutex" and "wq" would have been a better choice.

Good names should tell the human reader something.  What is the mutex
protecting?  What is the purpose of the workqueue?  Pick a name that
gives us some information like that, please!


You seem to have used AI to write this code, so the bad name choice was
presumably also done by AI.  But you are still associating your own good
name with the code.  You should try not to harm your good name by
letting things like this slide through unchallenged.

Jörn

--
Do not stop an army on its way home.
-- Sun Tzu
