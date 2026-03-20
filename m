Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7611A6814;
	Fri, 20 Mar 2026 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969231; cv=none; b=XYt0KZirhCev2JJ90IqaMWzG2QDso4IYKkLugOu7fzyDwFSBBsexaBhg8ZWF8mvzfUEDw+BWHc8GxmYdHudI8DD4AjztomvFK88naFIphn6kr0LLrerHnuzTgRvGiRvhQuyOVjd97iQvaFOsfPTKw/WnAqlMNl1xbsfm2hYs3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969231; c=relaxed/simple;
	bh=GE4nRzWbvb3a5WIS8rHFD/+5cyhHF6rQmr5JbitkbFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8Bwrv4H3vOpghUQd44uvifMv2QHz81gt+VXGxDhq+xP/Nj6eGpyLEEdHjcg3aEtXCvck5YRaTuoJea5eTZS53UUCgK3eJdNPkWWSI88th1oJk8Oo8btEPMS5ELvUn+shp3Yp37w/7emarBmCuSiTrKTXfDca1mNO8v2ZNnjQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62K0WDnw065667;
	Fri, 20 Mar 2026 09:32:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62K0WCw3065658
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Mar 2026 09:32:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9f66743b-70e0-4886-884e-5203f5c02ed8@I-love.SAKURA.ne.jp>
Date: Fri, 20 Mar 2026 09:32:12 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
To: George Vernon <contact@gvernon.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com, slava@dubeyko.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260311211309.27856-1-contact@gvernon.com>
 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
 <abnzsVk9JNN3alKq@Bertha>
 <dbacbf1c48ac5aa24f37c58bff995d7b03268db4.camel@ibm.com>
 <absr9g7LaMEHfw47@Bertha>
 <f84ae595-a084-4ded-9f99-964752a69f7d@I-love.SAKURA.ne.jp>
 <070d92639460b672a174d6a11b1e7d0b099b18cb@gvernon.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <070d92639460b672a174d6a11b1e7d0b099b18cb@gvernon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp

On 2026/03/19 21:26, George Vernon wrote:
> March 19, 2026 at 9:57 AM, "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp mailto:penguin-kernel@i-love.sakura.ne.jp?to=%22Tetsuo%20Handa%22%20%3Cpenguin-kernel%40i-love.sakura.ne.jp%3E > wrote:
> 
> 
>>
>> On 2026/03/19 7:49, George Anthony Vernon wrote:
>>
>>>
>>> Tetsuo, what do you think about doing your check inside
>>>  hfs_cat_find_brec? Something a bit like this:
>>>
>> Currently hfs_cat_find_brec() is called by only hfs_fill_super()
>> with cnid == HFS_ROOT_CNID. Are you planning to add more callers?
>>
>> If no, my patch
>>
>>  - if (rec.type != HFS_CDR_DIR)
>>  + if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
>>
>> is sufficient.
> 
> I'm trying to write a patch Slava will accept, maybe I didn't fully understand
> what he wanted but I think he wanted to fix hfs_cat_find_brec() so it should not
> return an incorrect cat record.

Neither do I understand. Is the diff below what Viacheslav Dubeyko wants?

 fs/hfs/catalog.c |   26 ++++++++++++++++----------
 fs/hfs/hfs_fs.h  |    4 ++--
 fs/hfs/super.c   |   11 +----------
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 7f5339ee57c1..e24fe49d5850 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -184,31 +184,37 @@ int hfs_cat_keycmp(const btree_key *key1, const btree_key *key2)
 
 /* Try to get a catalog entry for given catalog id */
 // move to read_super???
-int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
-		      struct hfs_find_data *fd)
+int hfs_cat_find_root_brec(struct super_block *sb, struct hfs_find_data *fd, hfs_cat_rec *rec)
 {
-	hfs_cat_rec rec;
 	int res, len, type;
 
-	hfs_cat_build_key(sb, fd->search_key, cnid, NULL);
-	res = hfs_brec_read(fd, &rec, sizeof(rec));
+	hfs_cat_build_key(sb, fd->search_key, HFS_ROOT_CNID, NULL);
+	res = hfs_brec_read(fd, rec, sizeof(*rec));
 	if (res)
 		return res;
 
-	type = rec.type;
+	type = rec->type;
 	if (type != HFS_CDR_THD && type != HFS_CDR_FTH) {
 		pr_err("found bad thread record in catalog\n");
 		return -EIO;
 	}
 
-	fd->search_key->cat.ParID = rec.thread.ParID;
-	len = fd->search_key->cat.CName.len = rec.thread.CName.len;
+	fd->search_key->cat.ParID = rec->thread.ParID;
+	len = fd->search_key->cat.CName.len = rec->thread.CName.len;
 	if (len > HFS_NAMELEN) {
 		pr_err("bad catalog namelength\n");
 		return -EIO;
 	}
-	memcpy(fd->search_key->cat.CName.name, rec.thread.CName.name, len);
-	return hfs_brec_find(fd);
+	memcpy(fd->search_key->cat.CName.name, rec->thread.CName.name, len);
+	res = hfs_brec_find(fd);
+	if (res)
+		return res;
+	if (fd->entrylength != sizeof(rec->dir))
+		return -EIO;
+	hfs_bnode_read(fd->bnode, rec, fd->entryoffset, sizeof(rec->dir));
+	if (rec->type != HFS_CDR_DIR || rec->dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
+		return -EIO;
+	return 0;
 }
 
 static inline
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..46641b60913f 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -145,8 +145,8 @@ extern int hfs_clear_vbm_bits(struct super_block *sb, u16 start, u16 count);
 /* catalog.c */
 extern int hfs_cat_keycmp(const btree_key *key1, const btree_key *key2);
 struct hfs_find_data;
-extern int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
-			     struct hfs_find_data *fd);
+extern int hfs_cat_find_root_brec(struct super_block *sb, struct hfs_find_data *fd,
+				  hfs_cat_rec *rec);
 extern int hfs_cat_create(u32 cnid, struct inode *dir,
 			  const struct qstr *str, struct inode *inode);
 extern int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str);
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 2e52acf282b0..c0be872d4079 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -354,16 +354,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	res = hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
 	if (res)
 		goto bail_no_root;
-	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
-	if (!res) {
-		if (fd.entrylength != sizeof(rec.dir)) {
-			res =  -EIO;
-			goto bail_hfs_find;
-		}
-		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
-		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
-			res = -EIO;
-	}
+	res = hfs_cat_find_root_brec(sb, &fd, &rec);
 	if (res)
 		goto bail_hfs_find;
 	res = -EINVAL;

