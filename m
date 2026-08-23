Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D381221F2F;
	Sun, 23 Aug 2026 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787452971; cv=none; b=XFA8Qv/LPRQcGtPsbOfTCMkULoLRR1EEGrR9eLU2rjEfFh5Bj3tZTRSF1psbu28DP5bmEGNnjHcydHiwD78i9slx5uMEaXPxEYkQs+ssRVflbdXymGTLsB6PTAYs0Hm2QXr8FNgZQyqWUKx8uFWbKyFDE/omm7iimG2SUVUPMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787452971; c=relaxed/simple;
	bh=BRGgKT/KGJLXr2r/FA4J7e0XJ+oisImpwbAy3ym6sYo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LKNxznIAw6HDwsXhVRZTtgt+p30KkckFuowaxJjYH57efO0T22gOGHxu5Mg5CSdX8vf5MzK6l5EGYKt8t4BWd7OtmqIETJ/gftTO2KZHS5EXwmvgLfZ2kw+5wy6xCVrlkesvtHAdBDjLHFiFY+tRcxGgf5KzcqhrVueKg/YB6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 51212A026F;
	Sun, 23 Aug 2026 02:36:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf09.hostedemail.com (Postfix) with ESMTPA id 96AC720028;
	Sun, 23 Aug 2026 02:36:37 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1266CF40068;
	Sat, 22 Aug 2026 22:36:37 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-09.internal (MEProxy); Sat, 22 Aug 2026 22:36:37 -0400
X-ME-Sender: <xms:tFyKao8-BX4D_ISxt4WXdttaaa6s52HZHLLNqPfsM0sl8I1-gk-3YQ>
    <xme:tFyKarjw0uc3HNVR_RGl2fSZRlUtvnYisbDG5tCLGBe0kiK6EM5Oy_XGqqld9m-NT
    FEAg_k6ArhHQ7smTveso8kEjT72rlXo4gudFOGyMF2dPqLhRQ67QYyE>
X-ME-Proxy-Cause: dmFkZTGJs7EL97/apjtGkJkG4XMj+ZRno47e7cllY8icGSPHmFj/sfjx8DmLMnFZ9F9/3x
    yumcEN46F02wwWLOyMyDz0GWf/usyZWvyonygZztbUyyqeZydHsRsY0DP4p+OVKIpbUhmE
    0lkaj/prWVBY1GQD/Tk2VQsFJ0R9P7MqZ9wxsHyJivuC0titEJ3AcYbqzm+qBifll7TDKn
    LnWEF1u/Wj3dMt8KWcoN/+/ciTLSov/Qgxq/GBAPHMluubq34XYq91un0UH/f3kWnoZvEf
    bCTujTmxeVoeidz+2ephZVlr6xBIlj9fWPDT6LiEN6ZvK3+bmypy/nLs4Cgp11g3GXzUkG
    CkDeHKEWpoEE3hBUf+EfqJUlmSxIBblPwMfgWx56PlVws/ytaAsY3CV418nGaECDlRC21a
    1skMVRSGuFgmV2Cx5tNou/gC1NCa6rQlcB7gjcWcwl5hTpOzJI9QzzVDHwnvRztyfCfzpe
    8YUhDilNgQ+5e7Zb5vX3/TYfbCWgyb2ppwR/SSfFbRrReQoX4rn13XE3mFXXWkGuYXxWiR
    iKzcHi7nWzkfcrnGKxPA4mY1DXmbX22ahgnC1ZXMubgAGcNtedpryrYyJKPrw04IYcHqhO
    KA/hHCgBPWdz42eeYI91lHEwOy7BXN2L1qn6+KGJhJs4pqjaSCg60u+IoRNg
X-ME-Proxy: <xmx:tVyKaskUyi7g34rKRjRan_OHUTShccqqMOdWxwLxm-__QD54PdHR6g>
    <xmx:tVyKapp9I8uWPf9rqYb05OFJBKmnzfl6Nqq9QtVxBorCTmy4y3zv6w>
    <xmx:tVyKalEMLmT9rA2195aOjV-ukj65B6HEkJtWnLXx6vpW2KaIeOmzhA>
    <xmx:tVyKalxS7u1v51wsW_9UYCJOzAa706LVsTOCUPjJ5rkfS_aIaFPLMg>
    <xmx:tVyKaqrMMqkkLKSSOxEaDLb1EKxAs7TMOtXERRKHi_ZFfiPssAMCFrOv>
Feedback-ID: i3a164872:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D2AFB700065; Sat, 22 Aug 2026 22:36:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 22 Aug 2026 21:36:16 -0500
From: "John Groves" <john@groves.net>
To: "Darrick J . Wong" <djwong@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>
Cc: "David Hildenbrand" <david@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "John Groves" <john@jagalactic.com>, "Dan Williams" <djbw@kernel.org>,
 "Bernd Schubert" <bschubert@ddn.com>,
 "Alison Schofield" <alison.schofield@intel.com>,
 "John Groves (jgroves)" <jgroves@micron.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Jake Edge" <jake@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vishal Verma" <vishal.l.verma@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
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
 "Gregory Price" <gourry@gourry.net>,
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
Message-Id: <e05d0dac-06d8-48e8-a2da-3b48fc9917ef@app.fastmail.com>
In-Reply-To: <20260822002111.GA6110@frogsfrogsfrogs>
References: 
 <0100019fc572ca94-ec363dd7-3a77-484b-b4b7-f2503a0931a6-000000@email.amazonses.com>
 <20260803022828.75776-1-john@jagalactic.com>
 <0100019fc5739e5d-bc002300-eede-4c40-9ca8-a277b754496e-000000@email.amazonses.com>
 <20260806043712.GB3560084@frogsfrogsfrogs>
 <CAJfpegtW4bFn=oNfTipCxhiExaqSXnhXeBd6Uq15FpepqCJaPQ@mail.gmail.com>
 <20260811-baugebiet-hofiert-fanden-3354f4a5e820@brauner>
 <ab642f3a-e377-4292-b2ff-bc970f5384e8@kernel.org>
 <CAJfpegsC-D0AJij3E=dbKzZCH0nijE7+rpPut-EnRd3r0uCMtg@mail.gmail.com>
 <20260822002111.GA6110@frogsfrogsfrogs>
Subject: Re: [PATCH V12 02/12] famfs: Module operations, fs_context, and mount
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Stat-Signature: o7q1szih7ett16848my5wsoukhn68mqh
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 96AC720028
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX18iMFNhA7TmeoqxkjvWL8O9N1TPd6uzy3Q=
X-HE-Tag: 1787452597-973066
X-HE-Meta: U2FsdGVkX198SyGgW3yN36a6CUd5zQD08V6UsHLy732PO9PJjxPKe/2MzoCHXZ8VcUWbykewone9tuhS055TJgJ7wOhC+y1Futa3+BQs63Fy2F4AySrjJe0pXIRRV/WSsBm7I2Q0Ueg3vBvNIQKiFohOv38IA+YHmtXYvCLQtDTsqhcC8uJPJgLKzbocG+bg6ytdCMLQuJu+8w8y9kaOHV+r/Ym+rfaY/5kaPTC6raKdlWEEGMYD2PsYrSd4zxbq07m9epgEBoqReqw7TV27IbR+/MwVCLfihmIwS4TQ0f18kQ4oFkkE/Xh153jJiUiBHjA6UzQn/2+MRr84c10kxSyfjpktwIoD



On Fri, Aug 21, 2026, at 7:21 PM, Darrick J. Wong wrote:
> On Fri, Aug 21, 2026 at 09:39:26PM +0200, Miklos Szeredi wrote:
> > On Fri, 21 Aug 2026 at 13:40, David Hildenbrand (Arm) <david@kernel.org> wrote:
> > 
> > > (a) Whether a fuse-based approach is feasible.
> > >
> > >     Are there any major blockers remaining?
> > 
> > No.
> > 
> > > (b) Whether a fuse-based approach is inefficient.
> > >
> > >     Are there scenarios remaining where performance or metadata overhead would
> > >     be bad without an easy way to improve the situation?
> > 
> > Lookups can be cached, extent mappings can also be cached.   After the
> > inode is in cache and the mapping is set up zero requests are needed
> > for open/mmap/read/write/close.
> > 
> > > (c) Whether a fuse-based approach is a bad conceptual fit.
> > >
> > >     Will fuse have to carry a lot of famfs special sauce that cannot
> > >     really be used elsewhere / generalized?
> > 
> > None.
> > 
> > But "can" and "will" are not the same.  The striping code might not be
> > very useful outside of famfs.
> > 
> > > (d) Whether a fuse-based approach is too invasive.
> > >
> > >     Will fuse extensions to support famfs actually make it harder to maintain or
> > >     slower on some paths?
> > 
> > No.
> > 
> > > (e) Whether a fuse-based approach will make famfs harder to extend.
> > >
> > >     Is there known follow-up work that will be hard/impossible to model in fuse?
> > 
> > It would actually make famfs much easier to extend, since the
> > directory structure, metadata, etc. is now controllable within the
> > userspace server.
> > 
> > > (f) Whether a fuse-based approach will reduce maintenance effor
> > >
> > >     Will maintaining fuse extensions possibly be harder than maintaining
> > >     standalone famfs?
> > 
> > Testing is a key point.  Famfs needs special hardware or emulation, so
> > it's not straightforward to test.  This could be solved by adding a
> > "dummy" mode to famfs server that exercises the same fuse API, but
> > instead of special hardware would just use plain memory.
> > 
> > > (g) Whether a fuse-based approach would make famfs more complex.
> > >
> > >     Will the shift to user space result in a significantly more complicated
> > >     overall solution that must be maintained?
> > 
> > The server would be somewhat more complex, since it's now implementing
> > things like pathname lookup, etc.  But the other stuff (managing file
> > maps) should be very similar.
> > 
> > > (h) Who would help drive the fuse approach?
> > >
> > >     Fuse people seem to be willing to help, but I expect that there must be a
> > >     close cooperation with John to make this fly. I don't expect that John
> > >     himself can easily (or understandably wants to :) ) do the heavy fuse
> > >     lifting.
> > 
> > Yes, this is where previous efforts seem to have gone off the rails.
> > So I agree to take responsibility for implementing the kernel side and
> > help with the server side on the condition that John has trust in
> > this.   I'm not promising -7.4, but can at least try.
> > 
> > Without John's trust I'm not taking this on.
> 
> Whatever path you and John decide on, I would very much like to see the
> question of Which famfs driver do we merge? to be resolved for 7.4.
> 
> --D

I certainly support this plan!

Thanks,
John

<snip>
