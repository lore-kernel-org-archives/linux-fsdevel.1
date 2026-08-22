Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E6259C80;
	Sat, 22 Aug 2026 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435739; cv=none; b=AfdJjXUirIVgqOP9vay8SmBRScSB8MOSokMegF5pGvfD5fpGkuPICjNN+kBbF0YR4Nm5h+Z8PujaxCIDGu7WLh/G4b9dDqwlkjfd2fZy4cFDixRP0fSsLUoITiJ1oPRH7gzvRfh51jmpszGwiVOayTbmu/pgqXuJOjzwM5vs8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435739; c=relaxed/simple;
	bh=ydPE5wNVkHjkOcVFlSC9awoRXv6Z/AdDZGJpHIyo2cE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=USHhcbBNuGOpIUdxeQiQVgWxddI/jM2UJwmxmdWDJbexofyw5pCpBcdudU5VrMLjd8OQKx0/hbHcCcoRLPVlHbEou0gGxBFME99GG0ftOdWZ5lGsSXrtua4d+U03wZ053VbvjnY/4MvP/n+lfG3fufaqCJHo1HyyyX35beMSOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 91911C0208;
	Sat, 22 Aug 2026 21:55:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf16.hostedemail.com (Postfix) with ESMTPA id B54802000F;
	Sat, 22 Aug 2026 21:55:33 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1E6A1F40066;
	Sat, 22 Aug 2026 17:55:33 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-09.internal (MEProxy); Sat, 22 Aug 2026 17:55:33 -0400
X-ME-Sender: <xms:1RqKape0S77Pnh2AjYL64eY3Q5dc_S_cHpqXYcjcTBLYpZ6vhk592w>
    <xme:1RqKaiBiPlN-DFDI8wLgTz9xfqMebuskJk0YcimwEAarqyTPyXln-EcrqN6lupcqP
    ZEhCngWqskVUBd4bsdIAsygHD7bMWVY6p92G9xtDXqfpoddwp5X8_in>
X-ME-Proxy-Cause: dmFkZTFjUGJSLhTKY9yALkhMu+m2yjYWVT52JZ283Gih8w4x+cjwvg9zDJwHfCVP1GGDDi
    1pPD28AKdjUOQxuojkgqH3AK2x6MRa5m89JyauDpbyPK/U6ftMaINL5fbMQU7tU6Ywlgj7
    Vh/nrFlF/tWBkk68sDvy5vlnf+9adIgDU8cUXreuCFYO1C6mb+S0LVf4jRxS7zPdPDHVYO
    gXzGZb8jhg3/IrRk3ZICcF01PTU7pr5rn7z7vToXDKy0HMv6il7qRlaRjAFK+gV6ApDne5
    m+1JIVfGkIWiixxpetlOzrdCOXCg4DcdRerLcSCMw1nGTe7qlG6pNsc2qvBsUZYl5B65IT
    SnEKEYs9Zf574dSnqOI/O91tQIb6b9C+BRKZbJJXl8kZKE8NtiEIOUzifppDm49VfAJM2U
    WoYNU/YTsxoyf1QC8VdUS2psIPNSLjJqvWErIPz848Mxh4ctHiMy0il0VF/vcpV49RRJYz
    HM/dGYHvkCDc9nhldhCYPrBSIOhPzkcxo1/t1staEteh4h71HwtHJJ9nLOOqSn9dy25dre
    SZPRWtkhbKLcAxOk2SdlixjSschJo6NwnOwt9Ltq6iPb1yASXbH5Ewqzo1thkMoeEihePv
    0S8hVSgjw87gpmxyPJF/yiYMgMPwerXpLD9m//4F8h7EVbpd6M2u/NIoBoNw
X-ME-Proxy: <xmx:1RqKalEeggbCCjzPEJn8V1jvqpsfuZIsG7wIxSniVIZGMCNaLMS0FA>
    <xmx:1RqKaoK8b7YMZ7XHZc9y-bUNazwaCxiW8WkBf651W4q0GD6cyTfpnw>
    <xmx:1RqKahlFCUIFxFQ1DArj_BglnUcRT4ysN-E61b0J6VVCNFznK6Yjaw>
    <xmx:1RqKaoQvqSEOWNu_SyxiKPPK8LG7SkH-haTnVnxx9I6nTB--r-ZQ1A>
    <xmx:1RqKarLmVCNgEGKUcHe52g7R0_6tirnb-xqbmuNQLVDDjapHyKwKjIMp>
Feedback-ID: i3a164872:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E6606700065; Sat, 22 Aug 2026 17:55:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 22 Aug 2026 16:55:12 -0500
From: "John Groves" <john@groves.net>
To: "Miklos Szeredi" <miklos@szeredi.hu>,
 "David Hildenbrand" <david@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
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
Message-Id: <ea56c85b-d564-4451-b704-58448a07bfa6@app.fastmail.com>
In-Reply-To: 
 <CAJfpegsC-D0AJij3E=dbKzZCH0nijE7+rpPut-EnRd3r0uCMtg@mail.gmail.com>
References: 
 <0100019fc572ca94-ec363dd7-3a77-484b-b4b7-f2503a0931a6-000000@email.amazonses.com>
 <20260803022828.75776-1-john@jagalactic.com>
 <0100019fc5739e5d-bc002300-eede-4c40-9ca8-a277b754496e-000000@email.amazonses.com>
 <20260806043712.GB3560084@frogsfrogsfrogs>
 <CAJfpegtW4bFn=oNfTipCxhiExaqSXnhXeBd6Uq15FpepqCJaPQ@mail.gmail.com>
 <20260811-baugebiet-hofiert-fanden-3354f4a5e820@brauner>
 <ab642f3a-e377-4292-b2ff-bc970f5384e8@kernel.org>
 <CAJfpegsC-D0AJij3E=dbKzZCH0nijE7+rpPut-EnRd3r0uCMtg@mail.gmail.com>
Subject: Re: [PATCH V12 02/12] famfs: Module operations, fs_context, and mount
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B54802000F
X-Stat-Signature: npbwmyrsypy9qfqbnarnhd3r6b8fomfa
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX19+CXO4zlpCISbOeuMg/9cCUpBF9o+4vdQ=
X-HE-Tag: 1787435733-876109
X-HE-Meta: U2FsdGVkX18MSx6jVSNc/IhF4520tHOo3JWBDgqxYGXZP9CTjXxFje7ZTobm2iJb1DkL2pQ3i1HGLyuTP0SNwxZsWU9wxxAvN+4TyL84mHIG+5dmk6ZZI8whvdrOtLBA7PwT1tpklCJwpr4HPPk5vj/b1AjmrkHWnNCd5vrkT+i4j7bgdFLVAZU70etG58RvWOKZJXvAhScDisHNjPQUc7DmR8vYoBLGhql2w/aK9rcCZ3f4ATdDObs81W3B1Vwm38NP7X/gfN4c6dkyZBLQ/ZkeC7x0SNWoP9G3pjn88qS2qFGLzrmcC0tk67clp56I11at74MjeA9vZK3fH/2IrF/RiXqVl63R



On Fri, Aug 21, 2026, at 2:39 PM, Miklos Szeredi wrote:
> On Fri, 21 Aug 2026 at 13:40, David Hildenbrand (Arm) <david@kernel.org> wrote:
> 
> > (a) Whether a fuse-based approach is feasible.
> >
> >     Are there any major blockers remaining?
> 
> No.

Famfs does work in fuse, but some of the asks are things that I don't see
how I can agree to. I think Miklos and I should discuss those 1:1, to figure
out if there is a way forward.

I think the virtual backing-dev thing is a non-starter, and I think that the famfs
portion of the fuse ABI basically can't live without extents that are
(daxdev, offset, length). 

And taking out the interleaved fmap structure, which I did in v11 because
it's my perception that certain fuse people *hated* it, is a bad idea IMO - it 
explodes famfs fmaps from a few hundred bytes to potentially many 
megabytes with no benefit to famfs. And famfs still needs compact 
interleaved maps in the metadata log, because that memory is expensive.

I have little doubt that 1) I don't fully understand Miklos' concerns and
priorities, and 2) Miklos and others don't fully understand mine. If you 
think I'm bad at explaining famfs now, you should have seen me trying 
3.5 years ago! ;)

IMO the on-list discussions have failed, and if people want famfs in fuse,
Miklos and I should try to work out a plan 1:1. I've thought this since the first 
time we discussed in f2f at LPC in Vienna, when you had questions about 
the interleaved layouts.

> 
> > (b) Whether a fuse-based approach is inefficient.
> >
> >     Are there scenarios remaining where performance or metadata overhead would
> >     be bad without an easy way to improve the situation?
> 
> Lookups can be cached, extent mappings can also be cached.   After the
> inode is in cache and the mapping is set up zero requests are needed
> for open/mmap/read/write/close.

True as far as it goes. The initial statement I made at LSFMM '24 was that
famfs would have to cache up complete file maps in-kernel, and that's what
I implemented.

> 
> > (c) Whether a fuse-based approach is a bad conceptual fit.
> >
> >     Will fuse have to carry a lot of famfs special sauce that cannot
> >     really be used elsewhere / generalized?
> 
> None.
> 
> But "can" and "will" are not the same.  The striping code might not be
> very useful outside of famfs.

Right. Famfs is a file system that uses dax instead of the page cache,
and that dax is character not block, and there is no backing store. Famfs
is not even storage, since the memory is volatile. So it's pretty different 
from mainline file system use cases.

In the thread from hell prior to LSFMM, somebody asked if I'm willing
to have the famfs code be shared. I don't even understand the question:
it's open source, of course it can be shared. Whether it will make much 
sense to do that is an open question IMO.

Also, I'm curious: if you don't know of a use case for the striping code outside
of famfs, why ask famfs to completely rewrite that?  (and I agree, other
than the eventual remote possibility of competing 'famfs-ng' fuse servers, 
I don't see much likelihood that this piece will be shared.)

> 
> > (d) Whether a fuse-based approach is too invasive.
> >
> >     Will fuse extensions to support famfs actually make it harder to maintain or
> >     slower on some paths?
> 
> No.

This does depend on what architectural changes are demanded of
famfs.

> 
> > (e) Whether a fuse-based approach will make famfs harder to extend.
> >
> >     Is there known follow-up work that will be hard/impossible to model in fuse?
> 
> It would actually make famfs much easier to extend, since the
> directory structure, metadata, etc. is now controllable within the
> userspace server.

That is also true of the standalone famfs implementation, although the
fuse approach is nicer for this.

> 
> > (f) Whether a fuse-based approach will reduce maintenance effor
> >
> >     Will maintaining fuse extensions possibly be harder than maintaining
> >     standalone famfs?
> 
> Testing is a key point.  Famfs needs special hardware or emulation, so
> it's not straightforward to test.  This could be solved by adding a
> "dummy" mode to famfs server that exercises the same fuse API, but
> instead of special hardware would just use plain memory.

Famfs has extensive CI that runs against both the standalone and fuse
implementations, including legacy versions that are still in use.

We copied some of the dax CI; some of the tests build a kernel, boot it
in qemu with NFIT virtual daxdevs, build the famfs user space in the VM, run
CI tests on famfs in the vm, etc.

We also run test automation on real shared memory hardware, but those
are still unicorn setups currently.

My team is quite serious about the testing (regardless of which version
goes upstream), and will be running automated testing against famfs 
on every kernel release, with multiple versions of the user space - and 
we'll be happy to share the recipes with others.

> 
> > (g) Whether a fuse-based approach would make famfs more complex.
> >
> >     Will the shift to user space result in a significantly more complicated
> >     overall solution that must be maintained?
> 
> The server would be somewhat more complex, since it's now implementing
> things like pathname lookup, etc.  But the other stuff (managing file
> maps) should be very similar.

The famfs fuse server exists, and it did add quite a bit of statefulness and
complexity to famfs relative to standalone. But that's sunk work, and it's 
pretty well tested. 

> 
> > (h) Who would help drive the fuse approach?
> >
> >     Fuse people seem to be willing to help, but I expect that there must be a
> >     close cooperation with John to make this fly. I don't expect that John
> >     himself can easily (or understandably wants to :) ) do the heavy fuse
> >     lifting.
> 
> Yes, this is where previous efforts seem to have gone off the rails.
> So I agree to take responsibility for implementing the kernel side and
> help with the server side on the condition that John has trust in
> this.   I'm not promising -7.4, but can at least try.
> 
> Without John's trust I'm not taking this on.

I think I already did the heavy fuse lifting. There are a handful of things
that need to be reconciled / negotiated.

Miklos, I trust that you are a good faith actor, although you seem to be
spread pretty thin. Can you commit to a series of 1:1 conversations with
me to try to work through the disconnects? 

> 
> > (i) Who would maintain any famfs fuse extensions and own any bugs?
> >
> >     famfs will possibly depend on fuse extensions that might initially only be
> >     used by famfs. Would the fuse maintainers just naturally deal with that?
> 
> I can take responsibility for the fuse kernel bits.

I can share responsibility for the famfs-specific stuff.

> 
> > (j) Whether a fuse-based approach has an end in sight.
> >
> >     famfs goes back .... quite a long time. It would be nice to close that
> >     chapter :)
> >
> >     Is there an end in sight, or could we end up in the same situation in 6m/1y/
> >     ...
> >
> >     IOW, is there a way to agree on an MVP that won't require a lot of further
> >     re-planning and changes to a fuse-based design?
> 
> I already sent patches to implement the dax dev mapping, and the
> striping.  We've discussed adding support for fixed backing ID, which
> was something that John asked for.  The only missing piece was adding
> a protocol extension to set up  simple extent mappings, which already
> existed in the famfs_fuse patch, just needed to be renamed and unused
> fields changed to "spare".

I think the virtual backing dev idea is wrong and bad. Let's discuss that.

> 
> We (Amir, Joanne, me) explained to John how this is exactly what's
> needed to make famfs work.  We've not seen an acceptance of that yet.

I am not feeling that my technical concerns have been heard and 
understood, and I have not thought that the suggested changes to famfs 
would preserve its fitness for purpose. 

Whether I'm right or wrong can be figured out if we discuss it 1:1. The 
on-list conversations have been something that my cardiologist asked
me to stop reading. (only semi-joking)

> 
> From my PoV this would be extra work, but in the longer term would
> expect to be less overall maintenance work and fuse would gain some
> useful features in the process.
> 
> Thanks,
> Miklos
> 

Wherever we are, we've gotten here without any 1:1 collaboration. Let's
try some.

Thank you,
John



