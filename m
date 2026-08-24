Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E835975;
	Mon, 24 Aug 2026 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615631; cv=none; b=F5e7PZgofxwb+1311GDvUnSzcrXoY5cWXnL5TTGTWoCIWlxxwJYqP6t0P44MLzbo/I0mgXr3x2/O5o273r8SSSXb8TS8sPUlmZwUjv11k29TgTGcMy7wPpA5bB4FicdpeXSlB5lrIhWW0uFi6eap0F2dgdXtREUGHvNU3UF6NhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615631; c=relaxed/simple;
	bh=YMtsvaPMhaJLi9vMElcaik8XpWsWPo0DE60Oo8CIAC8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z+a/mqTMtI2BwBIJFNjKqpscxsK4medahY5aXbxJAQeaYI2EECpctPbiVKICpE4lwdAOt8+qPDgqglyAGQedVPIpJZoFWW6LxxQEkso0hTlYdtqfcUYcCJuyns1HVS6miTNWGQkyPjl96bdJn3GQSKDycjQ5+Rbq+GWynmncjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 4F276C0280;
	Mon, 24 Aug 2026 23:53:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf01.hostedemail.com (Postfix) with ESMTPA id 87EBA6000F;
	Mon, 24 Aug 2026 23:53:46 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0367BF40066;
	Mon, 24 Aug 2026 19:53:45 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-09.internal (MEProxy); Mon, 24 Aug 2026 19:53:46 -0400
X-ME-Sender: <xms:idmMam0U9c6oPi-W2coEV8Cs9XAQGcQ-AfxK4K_4MroRIDcORW7ZkA>
    <xme:idmMaj50voR8iuh1wOoBIQ91LYrnfiN1VPP3BVkNCmGBnTI2VqT2rN475ATKvUY_X
    Z9LuE3y86yMFicubox5iFDjQkcB5EjcItE8ePye0D4QZdCUDZbpk7fy>
X-ME-Proxy-Cause: dmFkZTEPlWrA8HENT0TzF5ooj6Iaj5m9mxLjpIoBE4BdYNDSJvJp1GH7ifwg5Mq+6iBApX
    7kMbMTX8093DHpbX22Mvwf4n6M4/sSHxGMjLRer2dFtv6jj4DCQCkJd0HDYRD/FBZsRz28
    Um4maZ6ZKVl7f7jm3NpC/62tUXkOUM56QKKCRLRhOSOXGRkb1N/bTlQS4MjBiRbMvohLWK
    3BCKUIcjY1oDoyssiZYOmiub4aovfyUDuuhErPm3Mfatu1/YCuexa0cX9VYdkKgcYmfUw+
    V7GR1Oz+DjPcwpvZRvF/JHxiWW/u9lc/cnGzTE1G1Plo351x7lWKpfMU85HYCM6MaZrWGK
    kxF/dtkoa+khpHwXW2e//FJh9is47I96pwauX8pVcJSlkoiNkeoQqaJHrSuG5D7/JESmZD
    KIzZS1ofhuWRmmBYEU8ZlF/CARW5+tTKZ2e/K2vMLQiSkB9PpjQPa5h0UY73w5qeQ5WMAV
    xyM5MdJB+lUEgpD+zC9zgdMihfD3M23R8WWR6NxoCxSJS3jP8aMDNeJWTaoPQ4HeLOxNSQ
    dor91CTcIyX857qHsJ+hs3WFo+qsVzOdgIimDxjxDoyWJOKRbMGjOwPzBh9OZdvo4TdQ+Y
    U2RDn9u0bAhs2oy48mKXs419nncd3I1iSGmk0z6+wGIvK3kQCOCaJE69lqdg
X-ME-Proxy: <xmx:idmMasc_0a8WSE4rIEbjrGLAl8M4NrL9bIiXAqrI6hKV67sN76AdVg>
    <xmx:idmMasD_-BEJ2kE_g5juyM-SiO484CARdWVcQPoFVR0iCr4D2Q-qDQ>
    <xmx:idmMan-aDE9eHgtibZanUAmqmgokCAIWC7KX-K_BSZCyzait_kicwQ>
    <xmx:idmMavIv1tjhkQSbFF4JNHs2krdUWGx45yBpwVuSOuiJrh2rK86_Gg>
    <xmx:idmMaojpSFn9bik3AcdCmHJBR-MrgsoVy-fUa7VECFLvH4S_zU90F0dn>
Feedback-ID: i3a164872:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D36F8700069; Mon, 24 Aug 2026 19:53:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 18:53:25 -0500
From: "John Groves" <john@groves.net>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Cc: "David Hildenbrand" <david@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
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
Message-Id: <ed2ce261-50af-4515-99f0-51f69dc206af@app.fastmail.com>
In-Reply-To: 
 <CAJfpeguuL8He4dKC0+CQU3c=Ss9nDEH=9VckB5mqxOr01X2q4Q@mail.gmail.com>
References: 
 <0100019fc572ca94-ec363dd7-3a77-484b-b4b7-f2503a0931a6-000000@email.amazonses.com>
 <20260803022828.75776-1-john@jagalactic.com>
 <0100019fc5739e5d-bc002300-eede-4c40-9ca8-a277b754496e-000000@email.amazonses.com>
 <20260806043712.GB3560084@frogsfrogsfrogs>
 <CAJfpegtW4bFn=oNfTipCxhiExaqSXnhXeBd6Uq15FpepqCJaPQ@mail.gmail.com>
 <20260811-baugebiet-hofiert-fanden-3354f4a5e820@brauner>
 <ab642f3a-e377-4292-b2ff-bc970f5384e8@kernel.org>
 <CAJfpegsC-D0AJij3E=dbKzZCH0nijE7+rpPut-EnRd3r0uCMtg@mail.gmail.com>
 <ea56c85b-d564-4451-b704-58448a07bfa6@app.fastmail.com>
 <CAJfpeguuL8He4dKC0+CQU3c=Ss9nDEH=9VckB5mqxOr01X2q4Q@mail.gmail.com>
Subject: Re: [PATCH V12 02/12] famfs: Module operations, fs_context, and mount
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 87EBA6000F
X-Stat-Signature: q7byakz5pg5nc7rqry5nhs79cmtepzsf
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1+ptHQgWl9UUGuLM1QltQbKMTYYvKDEumQ=
X-HE-Tag: 1787615626-139192
X-HE-Meta: U2FsdGVkX1/eUFrzN8Xlrl5T3YxP8orMj0rjIT8WzMxRQK7jyIKR5aS24cRjZna3DAu5PajS3kpvghYR6q5My2ZJw1YBoHTqoQAs9ButWZgWRA9L6mc5glscvqiCgwTAEB1S0Qua7pdxmAr+XTWog+4WtiYEZYwgxJ6AW3q0VWTIm7jnEYecswjSBcaOq5iRueQlk+qPsgzUlKHEKoOFyjC3TfaBGakS0M6ytQKdZ4QCo+U6b7L6kDzgkKaoiaGd607WzQKNMn+YnYgZSuRH7urMf75Vy5Mu1wH7F7WAzBUlpNTQYRsAWIucDSI+SjC7wRs+38q4qUWcdG6EA/zShgMp7cBqjWiP4RRQkCzbTgkUiDw28WMNHA+Zsbg5ggY3



On Mon, Aug 24, 2026, at 2:41 AM, Miklos Szeredi wrote:
> On Sat, 22 Aug 2026 at 23:55, John Groves <john@groves.net> wrote:
> 
> > Famfs does work in fuse, but some of the asks are things that I don't see
> > how I can agree to. I think Miklos and I should discuss those 1:1, to figure
> > out if there is a way forward.
> >
> > I think the virtual backing-dev thing is a non-starter,
> 
> The virtual backing-dev is an abstraction.
> 
> Is it sufficient for you if I promise that this is going to do the
> same thing as the standalone famfs at the same performance level?
> 
> >  and I think that the famfs
> > portion of the fuse ABI basically can't live without extents that are
> > (daxdev, offset, length).
> 
> Sigh.  My proposal was (backing-id, offset, length).  Again this is an
> abstraction.  A backing ID can be a daxdev, a striped logical device
> or it can be a block dev or even a plain file.
> 
> > Also, I'm curious: if you don't know of a use case for the striping code outside
> > of famfs, why ask famfs to completely rewrite that?  (and I agree, other
> > than the eventual remote possibility of competing 'famfs-ng' fuse servers,
> > I don't see much likelihood that this piece will be shared.)
> 
> Because the striping feature fits much better into a virtual device
> API than the extent mapping API.  This is how striping has worked in
> linux for the last 30 years.
> 
> > Miklos, I trust that you are a good faith actor, although you seem to be
> > spread pretty thin. Can you commit to a series of 1:1 conversations with
> > me to try to work through the disconnects?
> 
> Fine, let's find a time.
> 
> Thanks,
> Miklos
> 

I'll ping you directly about times to talk. Thank you for being willing to do that.

Regards,
John
