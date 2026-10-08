Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667243E4A2;
	Thu,  8 Oct 2026 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460398; cv=none; b=o97Kq+bBxfQXGupIKB3+AXOlr6m4enZokWa3cnRuQhHdRG6Ne2St/iVVfj9o9BKH1xfz0tptL0YK9doRyzC6yz75m8sB9J2fISXGoli3s5LK4Udk0E6leVydujiCHlqbbB9A6eAZPxSy45o32JTcMw8qjbh3IxYpFbaHt3f9H6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460398; c=relaxed/simple;
	bh=ufKP2Nh4Vj+A+BKC42/rn4nT60aljrSSjAAgE174C4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQhj1KLkgEfLOXt3UC9slufJlS1nHkFG1rjZuALy9jfAF/0tCaB7W51CRR4En9bPTejYWN4asx+1NxcsL5BerUHFwLqHQdMIlRloHDzidoJ+FL5RUSNihYWJV3M8s8YQ7jmbRgakMdUMEKmHtSC2X4yFMsvetexJcBM2OXNbZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5B4B1F443;
	Thu,  8 Oct 2026 11:53:14 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAB3213354;
	Thu,  8 Oct 2026 11:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jUPuJCqEx2r9HAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Oct 2026 11:53:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E94EA13FC; Thu, 08 Oct 2026 13:53:06 +0200 (CEST)
Date: Thu, 8 Oct 2026 13:53:06 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Matthias Goergens <matthias.goergens@gmail.com>, jack@suse.cz, 
	repnop@google.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: report names longer than NAME_MAX
Message-ID: <kdorzbsbijlbh4fe25vdvjdlxvmrcjk3rolnfydvoedxlflgkb@nzfuss6yxcwg>
References: <20260926020851.2938961-1-matthias.goergens@gmail.com>
 <CAOQ4uxhxDOy1-vTSXGfA2c16e4iop_5M5goOih0pgSCZRvDrfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7ki65oeszutl43qt"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhxDOy1-vTSXGfA2c16e4iop_5M5goOih0pgSCZRvDrfw@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Result: default: False [0.00 / 50.00];
	TAGGED_RCPT(0.00)[]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: E5B4B1F443
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: 0.00
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org


--7ki65oeszutl43qt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue 06-10-26 15:33:20, Amir Goldstein wrote:
> On Sat, Sep 26, 2026 at 4:08 AM Matthias Goergens
> <matthias.goergens@gmail.com> wrote:
> >
> > fanotify keeps the length of a reported name in a u8, so it drops any
> > name longer than NAME_MAX and warns:
> >
> >   WARNING: fs/notify/fanotify/fanotify.h:217 at fanotify_handle_event+0x2e82/0x39f0
> >
> > Such names are legitimate on some filesystems.  vfat mounted with utf8
> > takes up to 255 UTF-16 characters, which are up to 765 bytes of UTF-8,
> > and FUSE accepts names up to PATH_MAX - 1.  readdir() and inotify report
> > them in full.  fanotify sends the event without the name, and for
> > FAN_RENAME it trips a second warning in copy_fid_info_to_user(), after
> > which read() fails with EFAULT and the event is lost.
> >
> > When syzbot hit this, Jan suggested accommodating names up to PATH_MAX
> > [1], the limit readdir() already applies to a name
> > (verify_dirent_name()).  Store the name lengths as u16, which keeps
> > struct fanotify_info at 8 bytes, and drop without a warning only names
> > of PATH_MAX bytes or more, which no path can refer to.  An event with
> > such a name can exceed a page, so allocate name events with kvmalloc(),
> > as Jan also suggested.  Names up to NAME_MAX are reported exactly as
> > before, and the record format is unchanged: an event with a long name is
> > just longer.
> >
> > Link: https://lore.kernel.org/all/20241112115059.ecvomkalee5m4i4i@quack3/ [1]
> > Fixes: 2d9374f09513 ("fanotify: use macros to get the offset to fanotify_info buffer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> > ---
> >
> > Tested in a VM with KASAN, lockdep and kmemleak: on vfat (utf8), names
> > of 258 to 765 bytes now arrive with their name, including FAN_RENAME,
> > for root and for an unprivileged watcher; FUSE names up to 4095 bytes
> > likewise, also a FAN_RENAME between two of them.  With kvmalloc()'s
> > kmalloc() attempt forced to fail, the events arrive intact from vmalloc.
> > No warnings.  The LTP fanotify and inotify tests give the same results
> > as before (fanotify20 skipped in both).
> >
> > 5.15.y fails the same way (the same warnings and EFAULT on 5.15.221),
> > and the patch applies there and fixes it.
> >
> > Honza, on the msdos report [2] you pointed at the filesystem, and msdos
> > now rejects such names (9d7ed813ee5f).  vfat cannot do the same without
> > making files that other systems wrote unreachable, and FUSE allows them
> > by design.
> >
> > [2] https://lore.kernel.org/all/3kzvlb3wpzbg6k6ttzp6rh2cfmz3hmmmlisgxjn5u4xmaaqibm@qkre7flkhejl/

...

> The fix for name_len < PATH_MAX looks good, but since you dealt with the
> the unexpected case of name_len > PATH_MAX more gracefully on event record
> time (empty name) I would rather that we treat it gracefully only on read() time
> and just report the event with no name instead of potentially breaking
> the read()
> of other events in the queue.

Guys, I wouldn't overengineer this. getname() never lets any path >= PATH_MAX
into the kernel, let alone individual dentries. So there's no
way this happens and the less code that pretends this can happen the
better. I guess I'm OK with checking *and loudly complaining* when
allocating such event but that's it. So what I plan to merge is the
attached patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--7ki65oeszutl43qt
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fanotify-report-names-longer-than-NAME_MAX.patch"

From ff05910cb1b77c2b229c5e6e260c6173a17b579b Mon Sep 17 00:00:00 2001
From: Matthias Goergens <matthias.goergens@gmail.com>
Date: Sat, 26 Sep 2026 10:08:51 +0800
Subject: [PATCH] fanotify: report names longer than NAME_MAX

fanotify keeps the length of a reported name in a u8, so it drops any
name longer than NAME_MAX and warns:

  WARNING: fs/notify/fanotify/fanotify.h:217 at fanotify_handle_event+0x2e82/0x39f0

Such names are legitimate on some filesystems.  vfat mounted with utf8
takes up to 255 UTF-16 characters, which are up to 765 bytes of UTF-8,
and FUSE accepts names up to PATH_MAX - 1.  readdir() and inotify report
them in full.  fanotify sends the event without the name, and for
FAN_RENAME it trips a second warning in copy_fid_info_to_user(), after
which read() fails with EFAULT and the event is lost.

When syzbot hit this, Jan suggested accommodating names up to PATH_MAX
[1], the limit readdir() already applies to a name
(verify_dirent_name()).  Store the name lengths as u16, which keeps
struct fanotify_info at 8 bytes, and drop without a warning only names
of PATH_MAX bytes or more, which no path can refer to.  An event with
such a name can exceed a page, so allocate name events with kvmalloc(),
as Jan also suggested.  Names up to NAME_MAX are reported exactly as
before, and the record format is unchanged: an event with a long name is
just longer.

Link: https://lore.kernel.org/all/20241112115059.ecvomkalee5m4i4i@quack3/ [1]
Fixes: 2d9374f09513 ("fanotify: use macros to get the offset to fanotify_info buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://patch.msgid.link/20260926020851.2938961-1-matthias.goergens@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify.c |  7 +++++--
 fs/notify/fanotify/fanotify.h | 21 ++++++++++++---------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a208a7ec1692..71b3a2361929 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -648,6 +648,9 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 	unsigned long name2_len = name2 ? name2->len : 0;
 	unsigned int len, size;
 
+	if (WARN_ON_ONCE(name_len >= PATH_MAX || name2_len >= PATH_MAX))
+		return NULL;
+
 	/* Reserve terminating null byte even for empty name */
 	size = sizeof(*fne) + name_len + name2_len + 2;
 	if (dir_fh_len)
@@ -656,7 +659,7 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 		size += FANOTIFY_FH_HDR_LEN + dir2_fh_len;
 	if (child_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
-	fne = kmalloc(size, gfp);
+	fne = kvmalloc(size, gfp);
 	if (!fne)
 		return NULL;
 
@@ -1050,7 +1053,7 @@ static void fanotify_free_fid_event(struct fanotify_event *event)
 
 static void fanotify_free_name_event(struct fanotify_event *event)
 {
-	kfree(FANOTIFY_NE(event));
+	kvfree(FANOTIFY_NE(event));
 }
 
 static void fanotify_free_error_event(struct fsnotify_group *group,
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 3710543dbf82..87ba788574bf 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -43,9 +43,16 @@ struct fanotify_info {
 	u8 dir_fh_totlen;
 	u8 dir2_fh_totlen;
 	u8 file_fh_totlen;
-	u8 name_len;
-	u8 name2_len;
-	u8 pad[3];
+	u8 pad;
+	/*
+	 * Deliberately not limited to NAME_MAX: some filesystems return longer
+	 * names (vfat up to 255 UTF-16 characters, as Windows allows, which is
+	 * up to 765 bytes of UTF-8; FUSE up to PATH_MAX - 1), and readdir() and
+	 * inotify report them in full. Only names of PATH_MAX bytes or more,
+	 * which no path can refer to, are dropped.
+	 */
+	u16 name_len;
+	u16 name2_len;
 	unsigned char buf[];
 	/*
 	 * (struct fanotify_fh) dir_fh starts at buf[0]
@@ -168,7 +175,7 @@ static inline char *fanotify_info_name2(struct fanotify_info *info)
 static inline void fanotify_info_init(struct fanotify_info *info)
 {
 	BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN + MAX_HANDLE_SZ > U8_MAX);
-	BUILD_BUG_ON(NAME_MAX > U8_MAX);
+	BUILD_BUG_ON(PATH_MAX > U16_MAX);
 
 	info->dir_fh_totlen = 0;
 	info->dir2_fh_totlen = 0;
@@ -214,8 +221,7 @@ static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
-	if (WARN_ON_ONCE(name->len > NAME_MAX) ||
-	    WARN_ON_ONCE(info->name2_len > 0))
+	if (WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->name_len = name->len;
@@ -225,9 +231,6 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 static inline void fanotify_info_copy_name2(struct fanotify_info *info,
 					    const struct qstr *name)
 {
-	if (WARN_ON_ONCE(name->len > NAME_MAX))
-		return;
-
 	info->name2_len = name->len;
 	strscpy(fanotify_info_name2(info), name->name, name->len + 1);
 }
-- 
2.51.0


--7ki65oeszutl43qt--
