Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026102116E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428683; cv=none; b=PwO2Y8X3DdWfJGEg7bnkKpg36plDs0mbhi+lDHdsgze5WX+3m+sspYVeJduvT3w0EgfVSQSj6Fkvup/e6Dc02Ok717ZJnslmz1EoPzj+XcRC0XFiu8BAPKAOoRpMKeqC19mM/ViOZiVzxoCdqfOLpHhjVfQeDtTRrlNMKTz/qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428683; c=relaxed/simple;
	bh=GFvbSxIizMSzNel1bIDjLvXLzTdabcMhB/A3RT7Rras=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSwESwYV410OXguo/p+aoDsj7fYRdADS0onYZ0sasWXVzQginDOkfpfnlwQt1oPCfQfT6se02e4pD11bmVq5KmZmEM1iYhoUI1ehlqRVTqB5fzjSLKCzt50ljtf64sHCTYR3dkP4Bpv/oOPs4eOzyKf+y02dBYdq8Pn6THEEE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hP2KzE5P; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hP2KzE5P"
Received: from macsyma.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net [173.48.113.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61IFV8lL025702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 10:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771428672; bh=SGrU15wevFlqutEeDaMDdVf9mmtkOhYJ3dwlLGhloJA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=hP2KzE5PwZipficDSEf6n41lJYZAY+gZxrcp4irH6G/K/PKCrpNIAnV3CeYJBeQku
	 Hunkx46dBPOh9c4EIKDZcuNL/5ADBSM6iuEj8cvPsz+bpbrEbIPW0QoGECM3hIfHaG
	 WzBzrZWMDjzMArDYJbe1/HS4WoD4FMlc4gAek7eocznyb/GoblGfJ8YippLL0udyO6
	 wJDZRwvGdVSQWX8zZtZSyoEGOR69wsrsjG+w9gVNc+72yX88TLAtdjMRcYykztgQOu
	 yTy2BDjgtZEj3N5U8F59e6Cho9u3ietP0aadDbps727x2Nv8KUNoUxQk76lvfFi2x0
	 3HSEtLVqw9IUQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D4E7559033B7; Wed, 18 Feb 2026 10:31:08 -0500 (EST)
Date: Wed, 18 Feb 2026 10:31:08 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "jack@suse.com" <jack@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Message-ID: <20260218153108.GE45984@macsyma-wired.lan>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>

I think this is definitely an interesting topic.  One thing that I
think we should consider is requirements (or feature requests, if
we're talking about an existing code base) to make it easier to run
performance testing.

A) Separate out the building of the benchamrks from the running of
    said benchmarks.  My pattern is to build a test appliance which
    can be uploaded to the system under test (SUT) which has all of
    the necessary dependencies that might be used (e.g., fio, dbench,
    etc.) precompiled.  The SUT might be a VM, or a device where
    running a compiler is prohibited by security policy (e.g., a
    machine in a data center), or a device which doesn't have a
    compiler installed, and/or where running the compiler would be
    slow and painful (e.g., an Android device).

B) Separate out fetching the benchmark components from the building.
   This might be because an enterprise might have local changes, so
   they want to use a version of these tools from a local repo.  It
   also could be that security policy prohibits downloading software
   from the network in an automated process, and there is a
   requirement that any softare to be built in the build environment
   has to reviewed by one or more human beings.

C) A modular way of storing the results.  I like to run my file system
   tests in a VM, which is deleted as soon as the test run is
   completed.  This significantly reduces the cost since the cost of
   the VM is only paid when a test is active.  But that means that the
   performance runs should not be assumed to be stored on the local
   file system where the benchmarks are run, but instead, the results
   should ideally be stored in some kind of flat file (ala Junit and
   Kunit files) which can then be collated in some kind of centralized
   store.

D) A standardized way of specifying the hardware configuration of the
   SUT.  This might include using VM's hosted at a hyperscale because
   of the cost advantage, and because very often, the softare defined
   storage in cloud VM's don't necessarily act like traditional HDD's
   or flash devices.)

I'll note that one of the concerns of running performance tests using
a VM is the noisy neighbor problem.  That is, what if the behavior of
other VM's on the host affects the performance of the test VM?  This
may vary depending on whether CPU or memory is subject to
overprovisioning (which may vary depending on the VM type).  There are
also VM types where all of the resources are dedicated to a single VM.

One thing that would be useful would be to have people running
benchmarks to run the exact same configuration (kernel version,
benchmark software versions, etc.) multiple times at different times
on the same VM type, so the variability of the benchmark results can
be measured.

Yes, this is a bit more work, but the benefits of using VM's, where
you don't have to maintain hardware, and deal with hard drive
failings, etc., means that some people might find the cost/benefits
tradeoffs to be appealing.

Cheers,

					- Ted

