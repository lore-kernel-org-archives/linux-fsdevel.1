Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE79460
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874186; cv=none; b=kamkmCbMhFQ753VAAFhdKIlznvU+oEXBVPPHruB5MAgVuBy/8aiMmRuJ8os846MndtpV0Srea6+YRsvh0zTNiB6LTh2j+N4916vH6gHALOPODAXDUn3L6gj26ebZraFSkVwOMUZpNqpueuNauY70CtEdLfW+GnBK6hLkq7ETyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874186; c=relaxed/simple;
	bh=mBpCyKL9seaIpl86KrAuEa1a5HwXuEY1o3oBQ8JzaM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNLgbz382fECfDREn1qN5ETm2z1r/GAHI4HMnlQ2EhiVT8+NG6vTdddSs6YyKR0brn1eyVKGVahKWH/kJOBi1Q6C4cRBVogwQxMjTgkD7s15tWAM5W7qUOSi8owfyehFbppr6u8jIBTSKhiuniySgXL0MFqKdISxw5pidcEFFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=Of5UAMj+; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="Of5UAMj+"
Date: Wed, 18 Mar 2026 22:49:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1773874171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rRPYIwAL4GuMcZwEwKD/MXyCtTBsgpxx8hm9/Y5udcQ=;
	b=Of5UAMj+gYm6r/f+twGLcSJuAMFq+c65JrbqSJTzzThQhhXVoGam/y3DbBshICCgugMuva
	2T51mUtW13YV5uVDjoIL2fc5UjYGaTj5QSTlEjHvVllbV7CWSYsBoUqBqK5GDz1RlBMMsb
	cFtzT0DUYPSR+YbR3EL3YLLwD44JKLY52+akMDmtJclKwXFfpT/F7eUV+ABpWgjH29ngFM
	BCcoNn5l1yePcF9NGBaDXMe5cB50O2ws4Re8Se7fAW5D867JEk5cT7JhzchMO8tK5rwWSV
	EdXCVi9tP6EOxQUaREv1xC1+62Tbq8HEMUy3fDf80+umtvnjv2/vxWqiDkZ+0Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com" <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <absr9g7LaMEHfw47@Bertha>
References: <20260311211309.27856-1-contact@gvernon.com>
 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
 <abnzsVk9JNN3alKq@Bertha>
 <dbacbf1c48ac5aa24f37c58bff995d7b03268db4.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbacbf1c48ac5aa24f37c58bff995d7b03268db4.camel@ibm.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 18, 2026 at 02:02:10AM +0000, Viacheslav Dubeyko wrote:
> On Wed, 2026-03-18 at 00:37 +0000, George Anthony Vernon wrote:
> > Sorry I struggled to understand you here Slava, there's a little bit lost in
> > translation I think.
> > 
> > On Mon, Mar 16, 2026 at 09:50:14PM +0000, Viacheslav Dubeyko wrote:
> > > by hfs_cat_find_brec(). But I cannot imagine that this logic can extract the
> > > record  with incorrect CNID. Because, it is the main goal of hfs_cat_find_brec()
> > > logic to extract the record that contains requested CNID. And if we requested
> > 
> > Do you mean that you do not think hfs_cat_find_brec *can* return a
> > record with incorrect CNID, or that you do not think it *should*?
> > 
> > I think Tetsuo is right that hfs_cat_find_brec() will return a catalog
> > record with different CNID in case of a malformed thread record.
> > 
> > On Mon, Mar 16, 2026 at 09:50:14PM +0000, Viacheslav Dubeyko wrote:
> > > logic to extract the record that contains requested CNID. And if we requested
> > > the HFS_ROOT_CNID, then this logic should return the record with exactly
> > > requested CNID or return the error code if such record has not been found.
> > 
> > Do you mean that hfs_cat_find_brec() should validate the CNID of the
> > catalog record found by hfs_brec_find()? I'm worried that validating
> > every B-tree lookup is going to be expensive. We could do it, however.
> > 
> > 
> 
> If you need to initialize the inode, then you need to find a file or a folder
> record in Catalog File (b-tree). It means that there are two possible ways: (1)
> find it by name, (2) find it by CNID.
> 
> If you know the name only, then you need to find a thread record by name. The
> thread record contains associated CNID that can be used to find the final
> file/folder record. It means that the second step is the searching the record by
> using the CNID. If CNID is OK, then we can find the record. If it is not OK,
> then we can find nothing or wrong record.
> 
> If we know CNID, then we can try to find the record by CNID directly. We will
> fail to find the record if there is no record with such CNID. But you don't need
> in thread record in the case of having CNID for the search.
> 

I don't think this is entirely right because we can't find a catalog
record by CNID directly. We also need its node name which is contained
in the thread record.

Knowing the CNID of the catalog entry we want to find allows us to
construct a key for the thread record, which we find and read. The
thread record tells us the CNID of the catalog record's parent and the
catalog record's file name, which we combine to create a key for the
catalog record. If the thread record is corrupted, the key we
constructed may find us a different catalog entry with different CNID.

- hfs_cat_find_brec() builds a key for the root CNID thread record [1]
- The contents of the thread record are read into an hfs_cat_rec by
hfs_brec_read(), which calls into hfs_bnode_read [2]
- hfs_cat_find_brec() then populates the key for the root CNID catalog
  record, using the fields of the thread record file [3]
- Finally we can search for the catalog record, and this will populate a
  new hfs_cat_rec [4]

So if the catalog thread record is corrupted, the bug Tetsuo described
can currently happen. The catalog record read from disk may have a
different CNID than the one we wanted to find provided to
hfs_cat_find_brec() hence the need to check the CNID of the catalog file
record returned by hfs_bnode_read in hfs_fill_super.

Therefore Tetsuo's patch to check the returned CNID after calling
hfs_cat_find_brec() seems correct to me, but I think it would be better
do that check inside hfs_cat_find_brec() before it returns, then as you
said the function will return the record with "exactly requested CNID or
return the error code if such record has not been found."

Tetsuo, what do you think about doing your check inside
hfs_cat_find_brec? Something a bit like this:

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index b80ba40e3877..5f2b4e223e68 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -185,10 +185,11 @@ int hfs_cat_keycmp(const btree_key *key1, const btree_key *key2)
 /* Try to get a catalog entry for given catalog id */
 // move to read_super???
 int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
-                     struct hfs_find_data *fd)
+                     struct hfs_find_data *fd, hfs_cat_rec *rec_out)
 {
        hfs_cat_rec rec;
        int res, len, type;
+       u32 cat_cnid;

        hfs_cat_build_key(sb, fd->search_key, cnid, NULL);
        res = hfs_brec_read(fd, &rec, sizeof(rec));
@@ -208,7 +209,37 @@ int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
                return -EIO;
        }
        memcpy(fd->search_key->cat.CName.name, rec.thread.CName.name, len);
-       return hfs_brec_find(fd);
+       res = hfs_brec_find(fd);
+       if (res)
+               return res;
+
+       if (fd->entrylength > sizeof(rec)) {
+               pr_err("Bad catalog entry size\n");
+               return -EIO;
+       }
+       hfs_bnode_read(fd->bnode, &rec, fd->entryoffset, fd->entrylength);
+       type = rec.type;
+       switch (type) {
+       case HFS_CDR_FIL:
+               cat_cnid = be32_to_cpu(rec.file.FlNum);
+               break;
+       case HFS_CDR_DIR:
+               cat_cnid = be32_to_cpu(rec.dir.DirID);
+               break;
+       default:
+               pr_err("Bad catalog record type\n");
+               pr_err("Filesystem may be corrupted, try performing fsck\n");
+               return -EIO;
+       }
+
+       if (cat_cnid != cnid) {
+               pr_err("Bad catalog record CNID %u, expected %u\n", cat_cnid, cnid);
+               pr_err("Volume is probably corrupted, try performing fsck.\n");
+               return -EIO;
+       }
+
+       *rec_out = rec;
+       return 0;
 }

 static inline


Thanks,

George

[1] https://elixir.bootlin.com/linux/v7.0-rc4/source/fs/hfs/catalog.c#L193
[2] https://elixir.bootlin.com/linux/v7.0-rc4/source/fs/hfs/bfind.c#L179
[3] https://elixir.bootlin.com/linux/v7.0-rc4/source/fs/hfs/catalog.c#L204
[4] https://elixir.bootlin.com/linux/v7.0-rc4/source/fs/hfs/catalog.c#L211
