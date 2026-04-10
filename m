Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF438A715
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803615; cv=none; b=bzh5I19+S/Ig3Si/RvI3WkSHSK1L8MtyaQRvVo9nwUpWoLfpWUSIRDT2G77G8ZCavoDRiHlwTCznG66MaRrBP6PzPx49xjw8CVuuoWjEW8b+jPNKb8SeS3VITQ++3DXPz3oh+u9VLtswf5+xBj4ZnY7Z+LDOOQN0JN6qy7fn00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803615; c=relaxed/simple;
	bh=pls8UUUI+uEAv854rg0zOFP4wF2+iCg9v0FKh/Jr8Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CeBMD76s4suUAl0ZErqNSRYQdeo05LOKLXDskNigLWtXBTDHSMg34xzzrnL4p6dDjoAZX7E+PgqlA2ExIoZgNRcYfyoXOKsy+q/TJNC1maEdwcAIOmKbwZkbO9nIqUMP/v/ft/vF7d/eO8tyCu3ZvwwiAnZHew2reASk6iUqGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl8Tmcbl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl8Tmcbl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso18297895e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775803611; x=1776408411; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnufnjucvVsDOT21h9grz6edlmIOM5lbkjYR3MJRD+Q=;
        b=bl8TmcblGh1AEo8g2cQ646X9/0jO0ELSCu3mtmfcsP7bLTyPtfkkbm/E+mv/q+BNC6
         hung4wcShiFvSnQIyyqGZaWrDgeIzCNOBMMRMoT0ufD1U59k+aUdiKSPekNVQGPCnuw3
         ktruwmfGNW5lYBAKah/Ybj//78caqjyKqiVoeZIegWF4fy4wTGYwxHhij6Rlci6fifEY
         7Mma6GA0GTUyRWzBLnPpQR+M0gVWuUcf+SdsAusg6wHs8tPrZO4+EWZT6Db7Yz8LOf2U
         yIBv/bqJE8MNrfIj7Cx/cYlYb0YXVqrviAjsM79m6MoRlMHBPxHVLf50ZAKYEAFHcShG
         MBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775803611; x=1776408411;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnufnjucvVsDOT21h9grz6edlmIOM5lbkjYR3MJRD+Q=;
        b=Qb7Se2q6nTkayIsmovJIGhX3FO7BLebJ+lkJJ68Qb10vGa+77viNYdUi17YzA5uqLO
         zqgh5ezHkkE6sr7/gT1FwGA8bCgjj68mmpMmrxzIJAy9ZeiOmDO2x5+1IMJ0w8QXw4yn
         nQxUDqeoUfD/6T+zZRf/QWkYEGF/9/Irw2WXxXQQrtwPBaiVWPl2bgM7KGtjgyxQ5+Yf
         qOkpTkx47br8kDKAFUGY7n1hCr/My+ScP2xueTd+Y5SwdOzDoIuI3hn7B/7JzwVGHksO
         SLs/Yl8dRunU79KYgPrCkjtf+ZUavWbmUZjpyRj6Hwg+TVVtsOChX9E6BJMt1tbm2Yxk
         TuDQ==
X-Gm-Message-State: AOJu0YwpZEJ5jvnRWnd1s+rZnpMipIa4+fn2u3e/GeQMExzM/JWf9ZA/
	VbLE4LqTAhe4xgrtTyYj3uYYZn1dSEd9B81u2xP67mdFRF4diu00CN+J
X-Gm-Gg: AeBDiesmfiG+8jcqf8LgyHq0/aK+Yy7KhGWzjNrCkj2xkh63cDv3DQV9+kxFWCJiY+c
	fiRoG3hEgE0HyAfCnKVYvV/xrEvBtpSe6Di5K1CJsDsNsrm/5Pb4tqIBMlBWcINsmlcuLYpKfq2
	qUg91BzzgVcPm20eDhWy1hKE7atIq1BpkVHC0TvcKOvZ/+suLlmEoT/B8kljIBrFl73QsMruFEm
	tkpF/9/4MaFU03u3pvZimfnhI1ncJbrt1wV17sbrX4FWAAJ3ipdXxzs71BIES7Fbz1ZPw40mCQA
	+sHjmkPSbQhUPLr12lwGnCwluTJjl6u9sMmH18BngN7pMuAhLiQ+V+z9Tdc6Y9XeKVreWUlmpW/
	pGXVGpj1rHPyh2FZFYZtQCJwfTsK1qFMm0u6gz3PwGEoGt8xgGKCvi0DIrbQuCwXHayV9pe9MoY
	XmQZ6DcizCLkDeol+swfynwY0KxWse6w==
X-Received: by 2002:a05:600c:4709:b0:488:ae6c:42c0 with SMTP id 5b1f17b1804b1-488d67d2ab2mr18915365e9.7.1775803611119;
        Thu, 09 Apr 2026 23:46:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5380feesm62746325e9.9.2026.04.09.23.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 23:46:50 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:46:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] ntfs: update attrib operations
Message-ID: <adic1vbVQJoOJq9n@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Namjae Jeon,

Commit 495e90fa3348 ("ntfs: update attrib operations") from Feb 13,
2026 (linux-next), leads to the following Smatch static checker
warning:

	fs/ntfs/attrib.c:196 ntfs_map_runlist_nolock()
	error: uninitialized symbol 'ctx_needs_reset'.

fs/ntfs/attrib.c
    78 int ntfs_map_runlist_nolock(struct ntfs_inode *ni, s64 vcn, struct ntfs_attr_search_ctx *ctx)
    79 {
    80         s64 end_vcn;
    81         unsigned long flags;
    82         struct ntfs_inode *base_ni;
    83         struct mft_record *m;
    84         struct attr_record *a;
    85         struct runlist_element *rl;
    86         struct folio *put_this_folio = NULL;
    87         int err = 0;
    88         bool ctx_is_temporary = false, ctx_needs_reset;
    89         struct ntfs_attr_search_ctx old_ctx = { NULL, };
    90         size_t new_rl_count;
    91 
    92         ntfs_debug("Mapping runlist part containing vcn 0x%llx.",
    93                         (unsigned long long)vcn);
    94         if (!NInoAttr(ni))
    95                 base_ni = ni;
    96         else
    97                 base_ni = ni->ext.base_ntfs_ino;
    98         if (!ctx) {
    99                 ctx_is_temporary = ctx_needs_reset = true;
    100                 m = map_mft_record(base_ni);
    101                 if (IS_ERR(m))
    102                         return PTR_ERR(m);
    103                 ctx = ntfs_attr_get_search_ctx(base_ni, m);
    104                 if (unlikely(!ctx)) {
    105                         err = -ENOMEM;
    106                         goto err_out;
    107                 }
    108         } else {
    109                 s64 allocated_size_vcn;
    110 
    111                 WARN_ON(IS_ERR(ctx->mrec));
    112                 a = ctx->attr;
    113                 if (!a->non_resident) {
    114                         err = -EIO;
    115                         goto err_out;

ctx_is_temporary is false. ctx_needs_reset is uninitialized.

    116                 }
    117                 end_vcn = le64_to_cpu(a->data.non_resident.highest_vcn);
    118                 read_lock_irqsave(&ni->size_lock, flags);
    119                 allocated_size_vcn =
    120                         ntfs_bytes_to_cluster(ni->vol, ni->allocated_size);
    121                 read_unlock_irqrestore(&ni->size_lock, flags);
    122                 if (!a->data.non_resident.lowest_vcn && end_vcn <= 0)
    123                         end_vcn = allocated_size_vcn - 1;
    124                 /*
    125                  * If we already have the attribute extent containing @vcn in
    126                  * @ctx, no need to look it up again.  We slightly cheat in
    127                  * that if vcn exceeds the allocated size, we will refuse to
    128                  * map the runlist below, so there is definitely no need to get
    129                  * the right attribute extent.
    130                  */
    131                 if (vcn >= allocated_size_vcn || (a->type == ni->type &&
    132                                 a->name_length == ni->name_len &&
    133                                 !memcmp((u8 *)a + le16_to_cpu(a->name_offset),
    134                                 ni->name, ni->name_len) &&
    135                                 le64_to_cpu(a->data.non_resident.lowest_vcn)
    136                                 <= vcn && end_vcn >= vcn))
    137                         ctx_needs_reset = false;
    138                 else {
    139                         /* Save the old search context. */
    140                         old_ctx = *ctx;
    141                         /*
    142                          * If the currently mapped (extent) inode is not the
    143                          * base inode we will unmap it when we reinitialize the
    144                          * search context which means we need to get a
    145                          * reference to the page containing the mapped mft
    146                          * record so we do not accidentally drop changes to the
    147                          * mft record when it has not been marked dirty yet.
    148                          */
    149                         if (old_ctx.base_ntfs_ino && old_ctx.ntfs_ino !=
    150                                         old_ctx.base_ntfs_ino) {
    151                                 put_this_folio = old_ctx.ntfs_ino->folio;
    152                                 folio_get(put_this_folio);
    153                         }
    154                         /*
    155                          * Reinitialize the search context so we can lookup the
    156                          * needed attribute extent.
    157                          */
    158                         ntfs_attr_reinit_search_ctx(ctx);
    159                         ctx_needs_reset = true;
    160                 }
    161         }
    162         if (ctx_needs_reset) {
    163                 err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
    164                                 CASE_SENSITIVE, vcn, NULL, 0, ctx);
    165                 if (unlikely(err)) {
    166                         if (err == -ENOENT)
    167                                 err = -EIO;
    168                         goto err_out;
    169                 }
    170                 WARN_ON(!ctx->attr->non_resident);
    171         }
    172         a = ctx->attr;
    173         /*
    174          * Only decompress the mapping pairs if @vcn is inside it.  Otherwise
    175          * we get into problems when we try to map an out of bounds vcn because
    176          * we then try to map the already mapped runlist fragment and
    177          * ntfs_mapping_pairs_decompress() fails.
    178          */
    179         end_vcn = le64_to_cpu(a->data.non_resident.highest_vcn) + 1;
    180         if (unlikely(vcn && vcn >= end_vcn)) {
    181                 err = -ENOENT;
    182                 goto err_out;
    183         }
    184         rl = ntfs_mapping_pairs_decompress(ni->vol, a, &ni->runlist, &new_rl_count);
    185         if (IS_ERR(rl))
    186                 err = PTR_ERR(rl);
    187         else {
    188                 ni->runlist.rl = rl;
    189                 ni->runlist.count = new_rl_count;
    190         }
    191 err_out:
    192         if (ctx_is_temporary) {
    193                 if (likely(ctx))
    194                         ntfs_attr_put_search_ctx(ctx);
    195                 unmap_mft_record(base_ni);
--> 196         } else if (ctx_needs_reset) {
                           ^^^^^^^^^^^^^^^
Uninitialized

    197                 /*
    198                  * If there is no attribute list, restoring the search context
    199                  * is accomplished simply by copying the saved context back over
    200                  * the caller supplied context.  If there is an attribute list,

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
