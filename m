Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8018493627;
	Sat, 22 Aug 2026 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435867; cv=none; b=WXfY9BoiZCZdU4Powvw8Orly+ALIOH+wIxHl+uGfn+05nYtRqk26zd+HZzKzxjmZdTOvvqta1wtGSKczg7OkDm/Pr9z4ONSIti7Ic5AH64j8v9dj3CQ4XygEBTbDJOyrGp/SVEX3wO2d1LFRlfsIpdpHolknEjJCP6JWEzC6ve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435867; c=relaxed/simple;
	bh=Fa6a65HZ3RxcrVRRoa2P5lQwMaQVfLRw48XBBZ0ZQoU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vDYaOWXQNJ8UJiMu6TYvoYmUsbWFvLUbJI9buUl2m/Gh1zf3tNXU5cCagOdKMD3E1lFh6YAlJKQrx+4PtkM7xuJEheQG/ICGEY2PM61FoXLzCLXGC8nH03rGgi4K1ZeaQH98NM6zZ+eHZyMsoWxxtps20YG5krJYgwV5RyiK3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A8D8516020C;
	Sat, 22 Aug 2026 21:57:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf01.hostedemail.com (Postfix) with ESMTPA id E37CB60010;
	Sat, 22 Aug 2026 21:57:42 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 675E1F40066;
	Sat, 22 Aug 2026 17:57:42 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-09.internal (MEProxy); Sat, 22 Aug 2026 17:57:42 -0400
X-ME-Sender: <xms:VhuKavocr_vv2e3dIDjd3dOPYsW5Lz3hh915ffoD_YwHFaihxUNUfg>
    <xme:VhuKakfGntvjxe4txzwkoX3_yOXpck9ABYSa47Q2VbhoF8IlwaeMgXThwrl48z7kK
    Jg9Bqd-SCp_UW4nX3GDyRXW973E5sPeBvENLF5FGBgVfJfvuFE-a-em>
X-ME-Proxy-Cause: dmFkZTFqwVFKSvNtSHaKxDKDPtBnJmh03jctdSmnK1ldkzGhnQ0a9+Fgr0oxnULnQgWtQz
    9OQlhvF867hW6nRICgdKfBqsbgeh2DRLQvL4DAWIylsxHBE1ngdg09lCeB+hIN7gHfhbX/
    VV0AssQpdhw5py68qb42rFJO0Ko6kADcKEfh84mAIe7JAi20xzYQJWdBPLtJJCcmVrpJcO
    mxIF1vHClzFhM1EmOFyeVafbeSbz9ch5/hTKQYbCex5vum4W55fnlHfQ6e1rdlegHRZZ3+
    V3Cq4zQ4fCShwRJSaZWi3I8FRT77OZn1COSEwtLMtpCROGm0ndnrGDSS9LnzpGW/v+KVWV
    lp435tg3Nwj2zsx63sXgphXC5uxeGgAK4hMyrsDq/wPrSW+DB2kXZPLdUbMIACzrK03T9r
    RxXYvuoKQZbz1VBd/3an21FBwIQweCEFDQlMRvsCv/vzJGXMeNff5W0rjmnnLUefbUu2zp
    vdBZlPqvkqlAbhlIzGUMrkE+Yd5BpW3MMIS1m7neD6qDxfG1dPyLP3kQl2BlRSodIBEt3Q
    XZwg0WSJrja4u3NMC6YiUeCNEmRdYz8rBSJB4AgsMKB2u+OXgoitpnwYsUNgW0yxTSr6yW
    k4lpfntNzPf02uN4LFVjUt2/tMDDT4wjhd3RwqCaIkpmqRFuTk92wKYC7BMg
X-ME-Proxy: <xmx:VhuKagQszj2uZzz0Vt33MvWkEIH_40KOREO2cJDPBUBxcsHr-cPnIg>
    <xmx:VhuKarljJHHF29pRjlJ1OLKBrmG0li-Lf7NuJRb8ChS4AnjphJ-7Pw>
    <xmx:VhuKaoTh4-fzWQ4eayUUjPgQrHmVh6gbHMasZmViH1LXaqumECO9xg>
    <xmx:VhuKahPr6SSAZ0hzcXL44fooRHu_ziKqwWkOlhWsU3PHWbU-axu6Gg>
    <xmx:VhuKapU8O5iShS7pfHCNgrR0M_9DbIk7hPvaaYQX6rb-8tb9rH6j-ESb>
Feedback-ID: i3a164872:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B1D5700065; Sat, 22 Aug 2026 17:57:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 22 Aug 2026 16:57:22 -0500
From: "John Groves" <john@groves.net>
To: "Darrick J . Wong" <djwong@kernel.org>,
 "Gregory Price" <gourry@gourry.net>
Cc: "John Groves" <john@jagalactic.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Dan Williams" <djbw@kernel.org>,
 "Bernd Schubert" <bschubert@ddn.com>,
 "Alison Schofield" <alison.schofield@intel.com>,
 "John Groves (jgroves)" <jgroves@micron.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Jake Edge" <jake@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vishal Verma" <vishal.l.verma@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Hildenbrand" <david@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "Stefan Hajnoczi" <shajnocz@redhat.com>,
 "Joanne Koong" <joannelkoong@gmail.com>,
 "Josef Bacik" <josef@toxicpanda.com>,
 "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Chen Linxuan" <chenlinxuan@uniontech.com>,
 "James Morse" <james.morse@arm.com>, "Fuad Tabba" <tabba@google.com>,
 "Sean Christopherson" <seanjc@google.com>,
 "Shivank Garg" <shivankg@amd.com>,
 "Ackerley Tng" <ackerleytng@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Ira Weiny" <iweiny@kernel.org>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Haren Myneni" <haren@linux.ibm.com>,
 "Pratyush Yadav" <pratyush@kernel.org>,
 "Giovanni Cabiddu" <giovanni.cabiddu@intel.com>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Gabriel Whigham" <gabewhigham@gmail.com>,
 "Aravind Ramesh" <arramesh@micron.com>,
 "Ajay Joshi" <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Message-Id: <de0be5a5-d171-4032-b162-c7bd9b95220e@app.fastmail.com>
In-Reply-To: <20260822174029.GC6110@frogsfrogsfrogs>
References: 
 <0100019fed5850ec-2bdfb17a-3086-44ea-8fdd-777d3ce12a33-000000@email.amazonses.com>
 <20260810202539.96378-1-john@jagalactic.com>
 <0100019fed5a5210-a09f1bdb-c705-44fc-8108-a7e7995a7af0-000000@email.amazonses.com>
 <20260822000728.GB6047@frogsfrogsfrogs>
 <aokdSo9li0RtEt35@gourry-fedora-PF4VCD3F>
 <20260822174029.GC6110@frogsfrogsfrogs>
Subject: Re: [PATCH v13 10/12] famfs: Add runtime operation-permission (opts) framework
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E37CB60010
X-Stat-Signature: icb8bedmehidbqn33d17sish5y7wsyhd
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1//6JhELknWQPIhQoyd1fPtKlnPqhMvYZk=
X-HE-Tag: 1787435862-138240
X-HE-Meta: U2FsdGVkX1/eHv012LV4zaH+1jpDrVLgp6l7QJVI/eAId8AhwMzEwlCtEqHZZQlvrXAA/8/Ax9bc0IeYOm4JndAhc0LwLoY7bFpCfLOXtsndZLwd/LSKZtSLiSHSfOzDyba6lc0Zkye/DdN9luxyk70UEfsfFMhRMrlEruUNTLlJf2LX//5tCH/UONtIc7vm0XbbA715hHsV110yWiL7CDYDyETfgTU25AnJ7fQHNTQXpIUyc7YO+qn6EyfmUz+1RgIxpTx/n7v+PkXqebXUUHsmudPtjX9I9rAbk4qwP4+sgA/YiHmCJiALt2w3mMdJ



On Sat, Aug 22, 2026, at 12:40 PM, Darrick J. Wong wrote:
> On Sat, Aug 22, 2026 at 12:18:58AM -0400, Gregory Price wrote:
> > On Fri, Aug 21, 2026 at 05:07:28PM -0700, Darrick J. Wong wrote:
> > > 
> > > But what prevents a malicious program that is /not/ the famfs client
> > > software but has CAP_SYS_ADMIN from doing that?
> > > 
> > 
> > Such a program can already unmount famfs, rebind the device to
> > device_dax, and mmap the whole range directly. MAP_CREATE isn't
> > handing it reach it didn't have. 

Gregory is right, but also: this is possible with fuse too, since the log
needs to be played into a tree that the fuse server consumes - in order
to avoid searching the log (order n) on every lookup. 

> 
> Thinking about this a little more -- some random root process that
> accidentally tries to create/modify a directory tree on a famfs mount
> will just end up with fmap-less files that won't work for IO or
> mmapping.  That's dorky, but I think you're right that it's no big deal.

I've had users do that, and yes it's dorky but NBD.  It can be locked
down tighter by turning off FAMFS_OPT_CREATE except during 
log play etc., but the main thing is "don't do that: it won't harm the 
system, but it also it won't do what you want".

'famfs fsck' finds those, and the famfs cli can clean them up.

> 
> 
> A bigger question I just thought of is sharing cxlmem between files (aka
> reflink).  Is that allowed?  I could see a theoretical usecase for
> programs A and B wanting to share some cxlmem for communication or
> heartbeats whilst having their own /a and /b files for their private
> memory.  Probably you'd just create a /common file to do that and not
> map the same cxlmem page into /a and /b, right?

Famfs doesn't support reflinks - I don't think there's a use case.

There is a pcq.c and libpcq.c in the famfs user space specifically for
using file pairs as producer/consumer queues - one file contains the
fields written by the producer, the other contains the fields written
by the consumer. This use case works great, but without cache-coherent
cxl memory (which is coming but not here yet AFAIK) libpcq has to verify
message sequence numbers and checksums to avoid reading messages 
from stale cache lines (i.e. loaded before valid).

I do have CI that creates cross linked files, which are detected by 
'famfs fsck'. 

> 
> But having said that, the fsdax code /can/ support sharing between
> files, so I wonder if famfs is prepared either (a) to enable that
> sharing or (b) reject a mapping that would overlap with an existing
> mapping?  Things will go very badly in the kernel if famfs doesn't set
> up the dax_folio state correctly.
> 
> --D
> 

Last I checked, if cross linked files get created (as test_errors.sh in my
smoke test suite does), you trigger a WARN_ONCE from dax,
but otherwise it does no harm to the system.

Thanks,
John

