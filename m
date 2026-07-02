Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC54A2E1D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000039; cv=none; b=CxfJOCn2EVz5TbPrNgED/KW3NzMhdX0S3gBpIJUdLmPFxmJGVzZvVk63GBfFj28pqJp2Ps2HtA2j7mEnhPGSoFRS9uP8z6i7D+oeMJlpcv5SULDXGXu7xwg9DRebq2EyzUI8N+pKUtTIEnrfDCmpcuYlUMcIktvxvhLh5Sem1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000039; c=relaxed/simple;
	bh=9vCzdsrDjRnNDopO8XrwVD6Ux3vuXiwvJ26XO8w0Q1M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hAU+1dwJBnkJYffSEzDXYoGYm6q8MpSlnzwQcoIffpv3A13YxpayPhv/ebr7Z0QKeSwqZSBO7TpWg10PcdApcvkDj08kO3Ggj4EhtTgXYAdjdvW0xOg/IN5Pu1er5wMg87CStTCA44Pwc8vHxbXhomlXXMmnPuJR1zttI3yibyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=HsIFnrwJ; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="HsIFnrwJ"
X-KPN-MessageId: 85860b35-761c-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 85860b35-761c-11f1-a59f-005056994fde;
	Thu, 02 Jul 2026 15:47:09 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 85850560-761c-11f1-b2fb-0050569977a2;
	Thu, 02 Jul 2026 15:47:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=iVIw1KSztBG5XbiiPT3rFIkRnppxNekEQmGA7UFDMX4=;
	b=HsIFnrwJ/QtllTx04+C9pkME/mhMGyDYSnYCI6k9g4ir0LDqT0iXnshqhHr6bbPtJ4X1an8qB2Z3Q
	 +tJO5Z6VrnmTsYQAUELtRUSb2yGVRXz00Ju503BM1hpkedxD0PszVb/vGL41lHsZiCVyBucTFwQq8+
	 3Az1R1v7E8nOpzJlFrLOmRxFRZ7hF39Iy1sz6alRCahu9xPx5+D+7eorwXsk9iTnT0ATzB3ndMsg4o
	 pnNIyBUtJidBa87kv46l1JqLpoooCJRU/qJOANVrJ4xTnehcgx8MDuzCo4p7cXMOFPaN2zQqRIkr69
	 3CJts3RqDMsYYliIsWyJDxhUoYspYhw==
X-KPN-MID: 33|gf0ONW+fymxcc6RJTTh39Z9+mMZxZYekkzX2oT74gM5hm4d37WfR+V88EtE4PbK
 Dj9pW/85t2SK8E94D/oj2vgfR3oW7yufkjw7/xwrc6iU=
X-CMASSUN: 33|xMJKv1fEE5T0AEgQ6BRiXBm1j8bPEc5HOs4lGff+5Ska6Sa85ejpf05EU1Og6XZ
 pzhDgTEVa8LIgHCyvifqQyA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 857a3792-761c-11f1-8edb-00505699eff2;
	Thu, 02 Jul 2026 15:47:09 +0200 (CEST)
Date: Thu, 2 Jul 2026 15:47:09 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Lorenzo Stoakes <ljs@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Brian Foster <bfoster@redhat.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Message-ID: <1699303859.3782023.1783000029571@kpc.webmail.kpnmail.nl>
In-Reply-To: <akZm3abpMGPe-s20@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <20260702093844.GA3491311@killaraus.ideasonboard.com>
 <akYx9blvVhIXB5A-@lucifer> <akZSOa4awK5l9x_w@bfoster>
 <akZW1RPqTc-4_7jW@lucifer>
 <20260702130740.GB3534761@killaraus.ideasonboard.com>
 <akZm3abpMGPe-s20@lucifer>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 02-07-2026 15:37 CEST schreef Lorenzo Stoakes <ljs@kernel.org>:
> 
>  
> On Thu, Jul 02, 2026 at 04:07:40PM +0300, Laurent Pinchart wrote:
> > On Thu, Jul 02, 2026 at 01:18:06PM +0100, Lorenzo Stoakes wrote:
> > > But then it becomes an arms race. People will get AI to try to defeat AI
> > > detection. So I'm not sure it's a safe road to go down.
> >
> > That would be my concern too.
> >
> > At this stage, I think it's better to make sure people know our
> > expectations, and expect that the vast majority will understand it's a
> > trust-based system where being caught willingly breaching trust will
> > have a very high cost. Or have we reached a point where that doesn't
> > work any more ?
> 
> Unfortunately there's a lot of people who have bad motives or feel there's
> prestige in kernel commits and are willing to cheat their way to it, or are
> pressured by their workplace, or etc. etc.
> 
> So I think this is far too idealistic. I've seen too much undisclosed AI being
> submitted and those people stridently denying they used it when it's brought up.
> 
> So I think tags are really useful to push back against those who are in good
> faith.
> 
> And for those who submit it dishonestly, I personally believe _reasonable_ and
> _strong_ evidence to believe it's generated should be enough to reject.
> 
> But there's not universal agreement on that, unfortunately, which makes it
> politically difficult.
> 
> I think honestly the only solution long-term will not even be to reject like
> this but rather we'll have to basically restrict newcomers to a very narrow band
> of submissions and have them build trust before they can send more.
> 

It's total insanity to expect from maintainers to deal with huge, deep, changes
in core subsystems by total unknown people, like you've had to deal with. What is
the chance you happen to refuse a commit by an isolated genius that just happen
to be able to do deep work without any kind of work leading up to that. And even
then, if they are genuinely a genius, it very likely won't smell like AI slop.

> Which really, really sucks but I don't see how we can keep the kernel alive any
> other way when the slop really ramps up.
> 
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
> 
> Thanks, Lorenzo
