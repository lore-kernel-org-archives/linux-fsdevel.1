Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078778F4A
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212825; cv=none; b=C+I7ah/ybXa5cdVmFte97orZm+Ikec14bpbyA+apWmqxdOv8uG6jlmzQnDQLT9Xvv/16aGdyCr3c67aX4EqyhTAnILXLvzPPVkhXfUzzb9AYXFwKgV4ls8iYVqEE3xTR5U3QlFgS34QIVQTmEOeBQbkywVibagcK2A6o4zKZoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212825; c=relaxed/simple;
	bh=QWGt3yYXGUvErlXif60E5XBK1F4dufhS+zYK3q7W1E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKVszfOGeV4nzSwCVSpQ2q2T29X34Ti+rnKmrs49edHbVp6KIXAYZgZL9kP5/vPhPizTKWah/oiurKB6RfNeI69muhi5O4ToCTqTse2pYnInq1RJpcRSbQR8l9Za25LnvJxrbZxzuc/3Yzo7yEzH/VzVfBJa63h0mW45/rgLMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GpOjnPJC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GpOjnPJC"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8dfb9139008so275659685a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776212823; x=1776817623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDpGBnaT3lT3hUJ3gOq0kFT1XqTcnbKHudND+6nYB6c=;
        b=GpOjnPJCL0fCxWKNCc2TR7IYRh/cpj8VGXStSuivNVsvV3k6kIKdyMNhdr3O3tSKVS
         UKdk9iQFL/pA/qDulrpnRYvEu8m4BVClNcX6hiXMvIpxfLLlvGoJOFICxWCvBf+0A6WY
         MnDjGibcRVuTBNDWsP4IQYw7kAMUjHLWtwbQq9v3b26HFbE20WDDoEfot5j+Q4IqaWJB
         n9+SKXe4JIzFgGMLRfCN0t/8KIJ7ujuPpSF/cNnDDW03Qvm0v7o5EiHgCTdjFkdICikl
         pJbNvncBej3yNkA0N6nYmxUEUJY3v0A90vADsdj011pRup2oTgRuYeD4K+MP0g6EUB2Q
         nlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212823; x=1776817623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDpGBnaT3lT3hUJ3gOq0kFT1XqTcnbKHudND+6nYB6c=;
        b=TlLxjhE2DROmy1UX51r3sExRoiBjB53Oa1100kRRa4nxiBkilBqalzJCol0C4y0irJ
         f8/ON3wwANIkyCjU5Q16tEQ9sY2FkgbF7xV7yNpHk/Y0Gvg/LcOHhzPZ2qeG2vnNVsuk
         1ULGK7aVClZc3lZbgN8UWqZeJ8LEm4qXlT3hvOUdWg2K1yn5OgaRU5uzEu9+1yO4l+Y/
         BAuTUriwgBKQyIkPS6Xx8LZbcsEhuw5cE7DoYwNtT77rDh+IhjkxVWRvKHrQ2OzNj4ER
         xqOlmqkVUeSdJt1vX0SwrwkYNnFpGTiUU80iavhldc5kktMWg9bDnXapfAd2EzX6mUqi
         LOyA==
X-Forwarded-Encrypted: i=1; AFNElJ/84h7/LKLlNNb5Iy3pbX5RJwXBRTXyazlXGJjuxhoAAHLT/6R/UCH0NUo5x9NutlJT1CuWDlIQweo+MvM1@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsovGR6hg82epkHFj1bJnH+ioL/3NqbxQ4+l02rXaPRFelPiK
	TjjEeBkNZeyYgeaw4PV097nTXJ2fpX6/dAG7Zsu+z+BwYcZrErtfe052rlXG5Bmy18A=
X-Gm-Gg: AeBDietPtqV9p6InfXa62aFRot18DsiXfNOHpX95Mez8WXEDs+0a0xaG2IgwSVtbFx0
	YFQhcBm8JlgSAeWLSK9Ns0BDmEjyUDqEBnM++iU4cELKzVza+WIpSjql7Yii9imA7+RpWSWF/a0
	VqCuVxNh+n2oQHRYPEPuwrhJpNlZc51m6IFMdqJTBxdHyLa+mMKEwHo7dJG3kgnNDzdZWSc7fL5
	zlMKN6NkXkbMEGfAWmqZQeZi+q9qDDb6HU9nE/sDJBYU9+RQF7Q+0sUtjd5+4gw/91pIqa8HKif
	fmSSkTITx8+JjjKeTWiHBPHQ4ItV1SVC2j6jiIGIJqBvJMyiW08BhBKUK5WJPq7mY6la1v36Mbl
	w3xbjU1wtxPnVoE9Ub7PFUAr2gwsDQXQoxaL4GrZ84hPx5mS+zG9HfsLTH9+r3TrNGfqv5fgiRB
	iSeCruhrvT4xsMOb8Z5k58lmZkCpnTN/iR4K83TfdoUd4lJeUXSm9tM8hxhUGQEJZi2nYVMTMu2
	QpIVAus4Ohx1vBhJTCDydg=
X-Received: by 2002:a05:620a:4411:b0:8d6:bd01:a684 with SMTP id af79cd13be357-8ddcd6f8560mr2828658085a.7.1776212822595;
        Tue, 14 Apr 2026 17:27:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33afc7sm7479885a.18.2026.04.14.17.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:27:01 -0700 (PDT)
Date: Tue, 14 Apr 2026 20:26:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Hannes Reinecke <hare@suse.de>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Strategies for memory deallocation/movement
 for Dynamic Capacity Pooling
Message-ID: <ad7bU9Guk_csFsEG@gourry-fedora-PF4VCD3F>
References: <e06deabf-44ad-4f3f-b817-78506c5e3203@suse.de>
 <20260413164359.00001c86@huawei.com>
 <ad1b4dVCgG27A5AK@gourry-fedora-PF4VCD3F>
 <38952332-dad4-4d17-a9c1-5c25d79f67b4@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38952332-dad4-4d17-a9c1-5c25d79f67b4@suse.de>

On Tue, Apr 14, 2026 at 09:08:22AM +0200, Hannes Reinecke wrote:
> On 4/13/26 23:10, Gregory Price wrote:
> > On Mon, Apr 13, 2026 at 04:43:59PM +0100, Jonathan Cameron wrote:
> > > > 
> > > > So quite some things to discuss; however, not sure if this isn't too
> > > > much of an arcane topic which should rather be directed at places like
> > > > LPC. But I'll let the PC decide.
> > > 
> > > Superficially feels a bit arcane, particularly as we are currently
> > > kicking untagged memory into the long grass as there are too many
> > > open questions on how to present it at all (e.g. related to Gregory's
> > > recent work on private nodes).  On recent CXL sync calls the proposal
> > > has been to do tagged memory first and only support allocation of
> > > all memory with a given tag in one go and full release.
> > > 
> > 
> > General consensus after last few months seems to be:
> > 
> > "While technically possible, untagged memory a bad idea for $REASONS"
> > 
> > I do not thing the private node case changes this, if anything it only
> > changes where the capacity ends up.
> > 
> Thing is, there will be things like CXL switches. And with that we'll get
> CXL memory behind the switch, making it possible to reshuffle memory
> 'behind the back' of the application.
> While the situation is similar to the current memory hotplug case
> (and, in fact, the mechanism on the host side will be the same I guess),
> the problem is now that we have a bit more flexibility.
> 
> The reason why one would want to reshuffle memory behind a CXL switch
> is to deallocate memory from one machine to reassign it to another
> machine. But as the request is just for 'memory' (not 'this particular
> CXL card holding _that_ memory'), the admin gets to decide _which_
> of the memory areas assigned to machine A should be moved to machine B.
> But how?
> 
> And that basically is the question: Can we get the admin / orchestration
> a better idea which of the memory blocks should be preferred for
> reassignment?
> I'm sure there are applications which have a pretty flexible memory
> allocation strategy which, with some prodding, they would be happy to
> relinquish. But I'm equally sure there are applications which react
> extremely allergic to memory being pulled of underneath them.
> And then there are 'modern' applications, which also don't like that
> but for them it really doesn't matter as one can simply restart them.
> 
> So it would be cool if we could address this, as then the admin
> /orchastration can make a far better choice which memory area to
> reassign.
> And it might even help in other scenarios (VM ballooning?), too.
> 

I'm a little confused by how you imagine this memory actually gets used.

  1) Are you hotplugging directly into the buddy as a normal NUMA node
     and letting the kernel dole out allocations to anything?
     - i.e.: existing add_memory_driver_managed() interface

  2) Are you trying to plop the entire dynamically added extent into a
     a specific workload?  Something like ioremap/mremap or ZONE_DEVICE
     exposed by a driver's /dev/fd ?

  3) Are you reserving this region specifically for in-kernel/driver
     use but not doled out to random users?

  4) Are you trying to just plop an entire extent into a VM (in which
     case you technically shouldn't even need to hotplug, in theory)?

  5) Are you trying to just decide which memory to release based on how
     much of it is used / hot / cold / etc?

I see lot of "Wondering if..." here based on what a switch COULD do, but
divorced from real use cases, 99.999% of what COULD be done is useless.

There are basically an infinite number of ways we should shuffle this
memory around - the actual question is what's useful?

Some use-case clarity here would be helpful.

~Gregory
