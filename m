Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDBC3D47DD;
	Wed,  5 Aug 2026 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961343; cv=none; b=Xv91gJSVUA6ZG1KV6RIHv9+oyp2pya2zTPzkCsQshIIc7eIQuH3sodxZxf3Sikw1k9t2vAYtm0Pu0RP8tujd8hTt7+oY8iDCTpwjENt+mdiI4+Oc/Mh8lM/szT+s2IbHRV4gkdU6u4DUmdMspFzblLzsDAXIF0eUDm2bk3EiM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961343; c=relaxed/simple;
	bh=bjJELJGjRJBekkjijGW+YIzeuEcnI4WoOsPTOsfXV0o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g9E2q58yJO6qWaAAEdC11kZqlbslgfzD68LYm+9dR/BTP1TJlZ2V9A+QA3qfvo2q/axjdaqT7lSUzToafhQrJg2CISm+oN8JCrRKmYkgN///DJmsE0YjZvoglYRdkmmp/nF1jtsy3zMZuC3dxQXQ1zvI6VP5/Rt5k1totCh//X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id E77DDC0543;
	Wed,  5 Aug 2026 20:22:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf03.hostedemail.com (Postfix) with ESMTPA id 26F416000D;
	Wed,  5 Aug 2026 20:22:09 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7ED7CF40066;
	Wed,  5 Aug 2026 16:22:08 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 16:22:08 -0400
X-ME-Sender: <xms:cJtzalyKJkYqo2-wlgWeiORImd-jFhF1R80AvvWE5Rgs4Cr66zW9dw>
    <xme:cJtzauvGyICl7o4ZonHm4ORvHHTTRh9mw_x75qpQfreWqYJtgAKqldp7v--sMjkuN
    RA4ILX6qXzeClYLnBGB--9OO9hjgudv3Dipedv6ysyGV_4K21Q8P7DU>
X-ME-Proxy-Cause: dmFkZTFjEpNeqnW4cjngFW8Sqgh9dzjywUMaqT88pXxIdOcsYHk8lLqwZVOzWB5kahBnIK
    flYqq7r30MaEfl1vgf0iHySKq7hvlcwdGgpvn8jUx6CdaOdmCYQlQnbK2VHgAbly3IQrjp
    ZkHL2KZt+tosdBMRAzIHETv9YIiqZerCc4qnrQukG46b8FBSgvT8MPa0MzlLOB6PIi7uzG
    IUd52cOpHrf0Tj9s7rJaLmOhUrUvKPwbTMu8aaTTbkevmeorqE3/7BKtnrSJlJcecEQ1XX
    XdOQR9AYj6RqtI4Rqe6nZD8SO0XR5hw28Y+rmhofNkzpuCml1uSvCVChULodiZoO2dJBT4
    WVk3HapLrIsvQYVAtFmY3wupPjqQ3ZD4EMxIzrSBouAZJx48Y5D4CFcJusg7boJYCC1Jy1
    E1oX5tsaQzJGNQ6sdih2lVsYjxwJUqvc1hoijxoPJUGv8Bdj4FoU26a957NNlb2vaeJJ9z
    5w4JDdFuaYLmjiU2U3k9DR/Y3Ntdp4TRI/I1ETR3apUA9LkKAQrNlaEMEVzYnpHO6t+hsy
    hfHOLsH/46zRSJIpH2CSU5LnGSJb8Uju7CrGbznDoHtI6u535r9YMJvZa0k9o1aZgIbvCU
    m5FhPZg4ihvFXL0mNfKZwZSTNBJeJ2wRv+qbv9EGlakRmpTy+B9Uxe/sYb2A
X-ME-Proxy: <xmx:cJtzarIRRm3trZ_hVL0rW_ZZFpjp2xgySJQ1qCMSrnNBdIXoSE37IA>
    <xmx:cJtzasBJ8a0TkOEgvIfQ8mFlnAeuj6dqxl1Wt1ijpW1KAHROYXDNNw>
    <xmx:cJtzajeci2Jpm3gxHj0GoUoPufQJdloxQ9keqqQflMHLVjVe06D4lA>
    <xmx:cJtzaj0d_5kmW3Mr03AeFtzGTxPmi1Ww74eiwlcOmSeMO3TeRZAfEA>
    <xmx:cJtzaij3wbHCxfzqTPioQVvvPYKJe9BtVxvQM1FbrFbNXm4BVk6mPoyK>
Feedback-ID: i3a164872:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71021700065; Wed,  5 Aug 2026 16:22:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 05 Aug 2026 15:21:48 -0500
From: "John Groves" <john@groves.net>
To: "Alison Schofield" <alison.schofield@intel.com>,
 "John Groves" <john@jagalactic.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, "Dan Williams" <djbw@kernel.org>,
 "Bernd Schubert" <bschubert@ddn.com>,
 "John Groves (jgroves)" <jgroves@micron.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Jake Edge" <jake@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vishal Verma" <vishal.l.verma@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Hildenbrand" <david@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
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
Message-Id: <94e39ae2-08e5-4606-a43a-d4a8ca71cdae@app.fastmail.com>
In-Reply-To: <anDoPTHjlOPhnnR-@aschofie-mobl2.lan>
References: 
 <0100019fc572ca94-ec363dd7-3a77-484b-b4b7-f2503a0931a6-000000@email.amazonses.com>
 <20260803022817.75759-1-john@jagalactic.com>
 <0100019fc5737596-636bde4f-7fc7-46a4-b011-63870098df09-000000@email.amazonses.com>
 <anDoPTHjlOPhnnR-@aschofie-mobl2.lan>
Subject: Re: [PATCH V12 01/12] dax: replace exported dax_dev_get() with non-allocating
 dax_dev_find()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Stat-Signature: u88sotnenpmaed7eg6m9y68wxw5o8a7k
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 26F416000D
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1+fBOagJ/x0yk7FSbvZQCPmf1ci6P7O35w=
X-HE-Tag: 1785961329-630173
X-HE-Meta: U2FsdGVkX1/OfdeEOIeasLDTdudUHUKiVoiprb1J8gtSE7pFYewT4bLB9wyKwXVCbmGYJmdnThriXZhqUuw/iRzInlkZ50Mp1/JDWmbma/r3+yIWKEm4jLAexZgiL/VB6gf+y+/qAcS1zm+ap5fFMYLFOMLaDRKfUSovnSOjP72nBNN7ctTj+2pUxBxQrPfGw7ak8QF3w+qsZDc+k1GrgOq0zAqS7k97pDIdh6WkTf6RQPHTlr6WsYwFnR+XNCSoVu3y1xVLGdgLb3JdZy6vFeAFTtORQfsu4tTJ6H1z9eQET6gIVx/TrgrpvRkdz1RKRLnR/YSvRwLKLFM9/ZVx6qxkoR9RF456FyTdxL+L7OL310Wt0E3XDoUuZsbffzp0buTougiPPWAg3lr4muhdSQ==



On Mon, Aug 3, 2026, at 2:13 PM, Alison Schofield wrote:
> On Mon, Aug 03, 2026 at 02:28:26AM +0000, John Groves wrote:
> > From: John Groves <John@Groves.net>
> > 
> > This fix is in response to a Sashiko review, and some subsequent
> > analysis.
> > 
> > dax_dev_get() uses iget5_locked() which creates a new inode if no
> > matching one exists. This is correct for the internal caller
> > (alloc_dax), but dangerous for external callers that look up devices
> > from user-supplied or metadata-supplied dev_t values:
> > 
> > 1. A new inode is created with DAXDEV_ALIVE set but no backing driver,
> >    no ops, and no IDA-allocated minor number.
> > 
> > 2. On teardown, dax_destroy_inode() warns because kill_dax() was never
> >    called, and dax_free_inode() calls ida_free() for a minor that was
> >    never ida_alloc'd -- potentially freeing the minor of a real device.
> > 
> > Add dax_dev_find() which uses ilookup5() for lookup-only semantics:
> > it returns an existing dax_device with an elevated inode reference, or
> > NULL if no device with the given dev_t exists. It never creates inodes.
> > A dax_alive() check under dax_read_lock() guards against returning a
> > device that is concurrently being torn down by kill_dax().
> > 
> > Make dax_dev_get() static again (internal to super.c for alloc_dax),
> > export dax_dev_find() instead, and update the two external callers
> > (famfs_inode.c, famfs.c). Also add the missing CONFIG_DAX=n stub.
> 
> There are no external callers yet as those arrive in subsequent
> famfs patches.
> 
> 
> > 
> > About the 'fixes' tag: this removes the export of dax_dev_get(),
> > which was flawed, and replaces is with dax_dev_find(). It feels like
> > the fixes tag makes sense for correcting an ABI error.
> > 
> > Fixes: 2ae624d5a555d ("dax: export dax_dev_get()")
> 
> Hi John,
> 
> I think this should be split.
> 
> Please send a standalone DAX patch that only removes the dax_dev_get()
> export (make it static again, drop the header declaration). It's unused
> in-tree and unsafe for its intended use, so it stands on its own with
> no FAMFS dependency. I'll take it through the DAX tree for 7.3.
> 
> Please drop the Fixes: tag on the removal. IIUC the stable team uses
> it to pick backports, and this shouldn't land in 7.2.y. Removing this
> fixes nothing since no in-tree code calls the symbol. Name the commit
> in prose instead, something like:
> 
>   Commit 2ae624d5a555 ("dax: export dax_dev_get()") exported
>   dax_dev_get() in v7.2 for famfs, which has not merged. The export
>   has never had an in-tree caller, so make dax_dev_get() static again.
> 
> Keep the dax_dev_find() addition in this famfs series, so the new export
> lands with famfs.
> 
> -- Alison
> 
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> I think you can carry the tags for both patches because the code
> should end up byte identical.
> 
> snip
> 

Thanks Alison, done in my local tree.

The patch that drops dev_dax_get() should hit your inbox today or tomorrow;
the one that adds dev_dax_find() will stay with this series.

Best,
John
