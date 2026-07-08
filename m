Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB53B47D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476432; cv=pass; b=Tqr31UYYk+b4LXTsdZFeJ5OEtOI8p9govuxSLEGw2pAcV4nhU6+ENThROe/h01afHgkPLU86t26KhCd8ey4pULgCLYg8x9uYqbgQSOf8W+QLyiErVpU1NWvbjspJZ8L0jRH/JM8sVWYq9rxk7afzr/rFtuavPQJNCyjWtP2nEYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476432; c=relaxed/simple;
	bh=a4s51OJSKt+NHGQxXJTYWDvPEeNPY/woXPXav6DxxX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICTcrWjNxQEhwZBVgtPjl+hNtiFVdZqNUJRRgcmLGJnsFUgrgSCOtVIh3/DulWtwQjNPcTI7lIrnuzUAKMQP0xeMRGB3mzozdtE/EidiYfRyyjt1DSZsklrnT2ytvbVCX6rroK+zBm585gjKkfYFP5lu8hH8E+NMcYJpOteZ28A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+R0WLlU; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+R0WLlU"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso77490f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 19:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783476427; cv=none;
        d=google.com; s=arc-20260327;
        b=GgSm81AOfOKks7utHPYOtXETT8Q6jDInxKSNZde6bmCo7hy98HfNQm3KD8RcixHntk
         aKhCMufa0pX43HMcjO4Ufc0SwzLFzeyvf7BUcF9gAVyesrIZvuxj8Hp4PxT/gkOJGojF
         ORfyyBaFqHAbSrO4g/SnV7PssSYiCXpH6IGtM6ZgvL+/xSEq7lPL7U60gp1UO8aYf3/L
         Q/nAl5I7YsJr4fU570j+PmcVqjXuGspV0quIdwlmbE1Ke4kBMO0zFpxB3Ts64efbCC5Z
         lY72I5zLhDY6RA7GKyzrHWEYbrecWaB8+XIcxCyy1r7d0LAGXUIBMBfN4lpAl8iUtae2
         ahcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ORF6ttoTrmazHMg6VNy9Hoketi9Owk/y4zWX+03jHq4=;
        fh=EHpGjxk8yLIMV6dzcARYyWSvkyZju8VUNxcRkgCbHhw=;
        b=kGjtuYcTas5mrY6UlYTMNY2HJNRUMBScquuZbWX/mug7aY6MGV+LNWMI1m7+J733j2
         CmHeZnFnnmdm+bGBsIoC6sN2E+mtXYvPYbyVYce6E7aDV1tEv4zl4tteu7ch/FRRdhh/
         eVaZi98kFSWXW5nX5q+dKqoUHqPzd88+4LtB5xbdJZzf9iYYRMsSY+bmxYhR21ks+2cX
         heN6WQ/X+3WyBkk8RsPTPoV0gB+KhJY7hSX+tidLylPqVq1IdlpQ2wIEQjurEaUW2JNM
         Lv/w+Nard3pq81GO7bopVNo2T/4W6UoAFDNr5h91vAVEQLwCHjPRLHgxUrUI5J4+dOO3
         28qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783476427; x=1784081227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ORF6ttoTrmazHMg6VNy9Hoketi9Owk/y4zWX+03jHq4=;
        b=V+R0WLlUWhLf3i9ucQ4ADMTQwP8A40RSGMCVqxIhZXv1LWn+KpAkmmcAN7EXcn2RSe
         YER2C6vrIyZGNpUi98VLnwi1NtjYeTg9mTd7xLWVGuhVqwi1WhXBJRmsNHtzkiY5zkGE
         RYN920y1l9gl8BrfuTAWI9qz5V4pAwozHF9guuVXRBQw6V7abEwLJ6Ae+IhtSRnybJNv
         DONZH1NgdiPBoenyeE+zQwisccRxYzExbbaXu90m3F3O1J55oNfFG0Mpl/Z6QFUnVX1+
         Ovu3hUAuUIP8zIAnnSf8WUQnF6voKrdPQtFg/sgJkohltOh6jriw5OYAd2XWXnOKiALg
         7Gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783476427; x=1784081227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ORF6ttoTrmazHMg6VNy9Hoketi9Owk/y4zWX+03jHq4=;
        b=G5BMdccHGqugwHaj1RPN6z1P/AuhH0ghivJ4HqUaPaoQD0G3bdeSPklGkdf70V91QI
         8EPIYH4xOpUdKne824n5TIg1BErL6fTN1oG/nIKYd5mPJZlHOuro1i5CMAh9fveazsNH
         Lqelcyl9jjFyxEwqA2ymBqjmRADYcFkxmrdbmkm571ANmNkVuZPrklWzmk88nfuMUjdK
         sE5D2GyZYsJMnYdT2cnR1cRIvzZRvCJh/YsENTOKQQqXyeYF4RlmFbZJXlyKDOq1oYPP
         F2GXTeNF9iX/1Y6OENEHFZ8fbIkkkgJzN/lW1QB4Atot43mNsMSIZp4MbujWNhvdeN7Y
         8mBg==
X-Forwarded-Encrypted: i=1; AHgh+RrjD0v1rWRCbdyhBRUsBJobEi4u+HPJZVy1xn13M1f3jabu1ZXoRzwoGh0H3G48mPe/h9VJ6MR1BJsJS97D@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzZfIdP+cvjkkFrxKgWozoD0bvyKHKoL/pwdC8gwS3cQBlcL8
	KRE0YJfoQkPHKwO+U8olqzwjSTH7Bdk55Qs/rwlrkxK8RLGtPWlRWd3h9mIPXHqJ6Sb/aFlM7k0
	gtGnQ1gM0yXV6ag18mxcGUZIycKnN3fE=
X-Gm-Gg: AfdE7ckL9wJ+z3ZvdGxhptGveHDFKKdL3ocoXptOVIns4EZ0uMpansL7cP1mE1JjXn5
	ONAfrAohaGmvlYw19RZSF79Vq8VXXWuE7HL4gaPb+SRb55OxGI4+jlJCNl16CDKPBunCMGhKXtn
	RQvNntLvuTOTyxvR3aX04JenWwDprbvv28YeHNyOT1LMM5QMLe7IiyaCThL1gElkBzUvj2qIjNF
	i5UlMNdNJGSJ5aeiB6wHs34vzfU8qI1qU3T2Pey4bzzXDMI5/ZlYzQr22/fFwgxCrevxpX8TM8Y
	CxfTks2OC53HoRDp3SttIqT4D8ZJsX7c3Sca8O+e8ohvWnDzjgsv
X-Received: by 2002:a5d:5846:0:b0:47c:de1f:7ad1 with SMTP id
 ffacd0b85a97d-47df081e2b9mr171008f8f.57.1783476427128; Tue, 07 Jul 2026
 19:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701033253.46420-1-changfengnan@bytedance.com>
 <20260701033253.46420-4-changfengnan@bytedance.com> <akT4tJzFSfrBxqdq@infradead.org>
 <CAJnrk1Y3yPeXBeBNo+DjTt8eRN-mc2F9apBCUn+j=GV7GMzi4g@mail.gmail.com>
 <akZ3GErzJSTtOn-H@infradead.org> <CAJnrk1ZijiWYU8YOmRf24xxwX0kH6vCe3ta89LfoX7v7j_JYLQ@mail.gmail.com>
 <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.e3ea485f.90a4.4656.9103.275b1cd29206@bytedance.com>
 <akettUm5gBD8nj56@infradead.org> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.a1148d7a.4a0d.4c6a.b14d.4583b6b728ce@bytedance.com>
 <CAJnrk1avS6qra8OvJdbexqM0xGT-FVZxVKe+TH4ZkFgfFv_oEQ@mail.gmail.com> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.20f172db.1248.4925.882c.ef1d31b23985@bytedance.com>
In-Reply-To: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.20f172db.1248.4925.882c.ef1d31b23985@bytedance.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 7 Jul 2026 19:06:53 -0700
X-Gm-Features: AVVi8Ce9dVSv5gb-MmQR63RNcTJ_JQ4saHZsMR2pN8NmucDCrIPXFtHDdz5i5Mo
Message-ID: <CAJnrk1aPS3Z_N+6Fto_B=Sgo6Wt62Cr6XHEwa-KzqjtQWyJ4Vg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] iomap: add simple dio path for small direct I/O
To: changfengnan <changfengnan@bytedance.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner <brauner@kernel.org>, djwong <djwong@kernel.org>, 
	ojaswin <ojaswin@linux.ibm.com>, dgc <dgc@kernel.org>, 
	linux-xfs <linux-xfs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	lidiangang@bytedance.com, "pankaj.raghav" <pankaj.raghav@linux.dev>, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:57=E2=80=AFPM changfengnan <changfengnan@bytedanc=
e.com> wrote:
>
>
> > From: "Joanne Koong"<joannelkoong@gmail.com>
> > Date:  Tue, Jul 7, 2026, 03:27
> > Subject:  Re: [PATCH v6 3/3] iomap: add simple dio path for small direc=
t I/O
> > To: "changfengnan"<changfengnan@bytedance.com>
> > Cc: "Christoph Hellwig"<hch@infradead.org>, "brauner"<brauner@kernel.or=
g>, "djwong"<djwong@kernel.org>, "ojaswin"<ojaswin@linux.ibm.com>, "dgc"<dg=
c@kernel.org>, "linux-xfs"<linux-xfs@vger.kernel.org>, "linux-fsdevel"<linu=
x-fsdevel@vger.kernel.org>, "linux-ext4"<linux-ext4@vger.kernel.org>, "linu=
x-kernel"<linux-kernel@vger.kernel.org>, <lidiangang@bytedance.com>, "panka=
j.raghav"<pankaj.raghav@linux.dev>, "Brian Foster"<bfoster@redhat.com>
> > On Mon, Jul 6, 2026 at 4:10=E2=80=AFAM changfengnan <changfengnan@byted=
ance.com> wrote:
> > >
> > > > From: "Christoph Hellwig"<hch@infradead.org>
> > > > Date:  Fri, Jul 3, 2026, 20:40
> > > > Subject:  Re: [PATCH v6 3/3] iomap: add simple dio path for small d=
irect I/O
> > > > To: "changfengnan"<changfengnan@bytedance.com>
> > > > Cc: "Joanne Koong"<joannelkoong@gmail.com>, "Christoph Hellwig"<hch=
@infradead.org>, "brauner"<brauner@kernel.org>, "djwong"<djwong@kernel.org>=
, "ojaswin"<ojaswin@linux.ibm.com>, "dgc"<dgc@kernel.org>, "linux-xfs"<linu=
x-xfs@vger.kernel.org>, "linux-fsdevel"<linux-fsdevel@vger.kernel.org>, "li=
nux-ext4"<linux-ext4@vger.kernel.org>, "linux-kernel"<linux-kernel@vger.ker=
nel.org>, <lidiangang@bytedance.com>, "pankaj.raghav"<pankaj.raghav@linux.d=
ev>, "Brian Foster"<bfoster@redhat.com>
> > > > On Fri, Jul 03, 2026 at 05:13:12PM +0800, changfengnan wrote:
> > > > > taken, which introduced some overhead.
> > > > > I implemented some optimizations based on Christoph=E2=80=99s sug=
gestions and
> > > > > made some modifications to `iomap_process`;
> > > > > Now, XFS performance is essentially unchanged, while ext4 still s=
hows a
> > > > > 1.5% drop; I will continue to investigate the cause..   I=E2=80=
=99ve attached the patch.
> > > > > Actually, I had expected that switching to `iomap_next` would imp=
rove
> > > > > performance, since it avoids an indirect call.
> > > >
> > > > I don't think it will for you - the direct I/O readers don't have
> > > > iomap_end methods, so you still have the same number of indirect
> > > > calls.  What could help is to inline the iterator as seen in Joanne=
s'
> > > > fist demo series.  We could even look into doing that only for simp=
le
> > > > dio in a first step, shifting the burden to use the simple method
> > > > to the callers (at least for the POC).
> > >
> > > I'm not sure if this is what you had in mind, but I made some
> > > adjustments referencing Joannes' first patch, and using this approach=
,
> > > there was no performance degradation.
> >
> > Thanks, Fengnan. This is awesome that it got the degradation down to ze=
ro.
> >
> > Would you be able to test how this change performs on your benchmarks?:
>
> XFS basically has no performance degradation, while ext4 experiences
> a 1-1.5% performance degradation.
>
> Round 1:
>     d67      xfs : 2.04M, 2.05M, 2.04M, 2.04M, 2.04M  avg=3D2.042M
>     d67      ext4: 2.12M, 2.12M, 2.12M, 2.12M, 2.12M  avg=3D2.120M
>     joanne86 xfs : 2.13M, 2.05M, 2.04M, 2.05M, 2.05M  avg=3D2.064M
>     joanne86 ext4: 2.11M, 2.11M, 2.11M, 2.11M, 2.11M  avg=3D2.110M
>
>   Round 2:
>     d67      xfs : 2.05M, 2.05M, 2.05M, 2.05M, 2.05M  avg=3D2.050M
>     d67      ext4: 2.12M, 2.12M, 2.12M, 2.12M, 2.12M  avg=3D2.120M
>     joanne86 xfs : 2.04M, 2.04M, 2.04M, 2.04M, 2.05M  avg=3D2.042M
>     joanne86 ext4: 2.09M, 2.08M, 2.09M, 2.10M, 2.09M  avg=3D2.090M
>
>   Round 3:
>     d67      xfs : 2.04M, 2.04M, 2.04M, 2.04M, 2.05M  avg=3D2.042M
>     d67      ext4: 2.12M, 2.12M, 2.11M, 2.12M, 2.12M  avg=3D2.118M
>     joanne86 xfs : 2.04M, 2.05M, 2.04M, 2.04M, 2.04M  avg=3D2.042M
>     joanne86 ext4: 2.09M, 2.09M, 2.08M, 2.09M, 2.09M  avg=3D2.088M
>

Thanks. I'm not sure why it makes ext4 worse. Maybe it being inlined
bloats it too much so it leads to more frontend stalls/icache misses
than what the devirtualization helps with? Looking at the begin
functions, ext4's is around 2.5x larger than xfs's. It also looks like
ext4's read_iomap_begin function has 2 callers, so I think that may
not get automatically inlined whereas xfs's will since
xfs_read_iomap_begin just has 1 caller, though I don't know if that
ends up mattering.

I'm seeing that ext4_iomap_begin is ~1570 bytes vs.
xfs_read_iomap_begin is ~635 bytes. It looks like though
ext4_iomap_begin is a combined read + write begin, whereas xfs's is a
dedicated read-only begin. If we separate ext4_iomap_begin into
dedicated read vs write begins, then I think this gets
ext4_read_iomap_begin down to ~230 bytes.

Would you be able to test if this improves the ext4 performance you're seei=
ng?:

change #1: separate out ext4_iomap_begin into ext4_read/write_iomap_begin

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4c30dd8dbec7..54cdecbc7539 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3771,8 +3771,46 @@ static int ext4_iomap_alloc(struct inode
*inode, struct ext4_map_blocks *map,
 }


-static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t len=
gth,
-               unsigned flags, struct iomap *iomap, struct iomap *srcmap)
+static int ext4_read_iomap_begin(struct inode *inode, loff_t offset,
+               loff_t length, unsigned int flags, struct iomap *iomap,
+               struct iomap *srcmap)
+{
+       int ret;
+       struct ext4_map_blocks map;
+       u8 blkbits =3D inode->i_blkbits;
+
+       if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+               return -EINVAL;
+
+       if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
+               return -ERANGE;
+
+       /*
+        * Calculate the first and last logical blocks respectively.
+        */
+       map.m_lblk =3D offset >> blkbits;
+       map.m_len =3D min_t(loff_t, (offset + length - 1) >> blkbits,
+                         EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+
+       ret =3D ext4_map_blocks(NULL, inode, &map, 0);
+       if (ret < 0)
+               return ret;
+
+       /*
+        * When inline encryption is enabled, sometimes I/O to an encrypted=
 file
+        * has to be broken up to guarantee DUN contiguity.  Handle this by
+        * limiting the length of the mapping returned.
+        */
+       map.m_len =3D fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len)=
;
+
+       ext4_set_iomap(inode, iomap, &map, offset, length, flags);
+
+       return 0;
+}
+
+static int ext4_write_iomap_begin(struct inode *inode, loff_t offset,
+               loff_t length, unsigned int flags, struct iomap *iomap,
+               struct iomap *srcmap)
 {
        int ret;
        struct ext4_map_blocks map;
@@ -3793,37 +3831,33 @@ static int ext4_iomap_begin(struct inode
*inode, loff_t offset, loff_t length,
                          EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
        orig_mlen =3D map.m_len;

-       if (flags & IOMAP_WRITE) {
+       /*
+        * We check here if the blocks are already allocated, then we
+        * don't need to start a journal txn and we can directly return
+        * the mapping information. This could boost performance
+        * especially in multi-threaded overwrite requests.
+        */
+       if (offset + length <=3D i_size_read(inode)) {
+               ret =3D ext4_map_blocks(NULL, inode, &map, 0);
                /*
-                * We check here if the blocks are already allocated, then =
we
-                * don't need to start a journal txn and we can directly re=
turn
-                * the mapping information. This could boost performance
-                * especially in multi-threaded overwrite requests.
+                * For DAX we convert extents to initialized ones before
+                * copying the data, otherwise we do it after I/O so
+                * there's no need to call into ext4_iomap_alloc().
                 */
-               if (offset + length <=3D i_size_read(inode)) {
-                       ret =3D ext4_map_blocks(NULL, inode, &map, 0);
+               if ((map.m_flags & EXT4_MAP_MAPPED) ||
+                   (!(flags & IOMAP_DAX) &&
+                    (map.m_flags & EXT4_MAP_UNWRITTEN))) {
                        /*
-                        * For DAX we convert extents to initialized ones b=
efore
-                        * copying the data, otherwise we do it after I/O s=
o
-                        * there's no need to call into ext4_iomap_alloc().
+                        * For atomic writes the entire requested
+                        * length should be mapped.
                         */
-                       if ((map.m_flags & EXT4_MAP_MAPPED) ||
-                           (!(flags & IOMAP_DAX) &&
-                            (map.m_flags & EXT4_MAP_UNWRITTEN))) {
-                               /*
-                                * For atomic writes the entire requested
-                                * length should be mapped.
-                                */
-                               if (ret =3D=3D orig_mlen ||
-                                   (!(flags & IOMAP_ATOMIC) && ret > 0))
-                                       goto out;
-                       }
-                       map.m_len =3D orig_mlen;
+                       if (ret =3D=3D orig_mlen ||
+                           (!(flags & IOMAP_ATOMIC) && ret > 0))
+                               goto out;
                }
-               ret =3D ext4_iomap_alloc(inode, &map, flags);
-       } else {
-               ret =3D ext4_map_blocks(NULL, inode, &map, 0);
+               map.m_len =3D orig_mlen;
        }
+       ret =3D ext4_iomap_alloc(inode, &map, flags);

        if (ret < 0)
                return ret;
@@ -3850,6 +3884,16 @@ static int ext4_iomap_begin(struct inode
*inode, loff_t offset, loff_t length,
        return 0;
 }

+static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t len=
gth,
+               unsigned flags, struct iomap *iomap, struct iomap *srcmap)
+{
+       if (flags & IOMAP_WRITE)
+               return ext4_write_iomap_begin(inode, offset, length, flags,
+                                             iomap, srcmap);
+       return ext4_read_iomap_begin(inode, offset, length, flags, iomap,
+                                    srcmap);
+}
+
 int ext4_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
                           struct iomap *srcmap)
 {


change #2: use ext4_read_iomap_next in iomap_dio_rw

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 755fde1baf03..bef2851d5466 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -4006,6 +4006,8 @@ static inline void
ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)

 int ext4_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
                struct iomap *srcmap);
+int ext4_read_iomap_next(const struct iomap_iter *iter, struct iomap *ioma=
p,
+               struct iomap *srcmap);
 int ext4_iomap_next_report(const struct iomap_iter *iter, struct iomap *io=
map,
                struct iomap *srcmap);

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index bf0c18cf1017..48c6a76a16a1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -91,7 +91,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb
*iocb, struct iov_iter *to)
                return generic_file_read_iter(iocb, to);
        }

-       ret =3D iomap_dio_rw(iocb, to, ext4_iomap_next, NULL,
+       ret =3D iomap_dio_rw(iocb, to, ext4_read_iomap_next, NULL,
                           IOMAP_DIO_NO_IOMAP_END, NULL, 0);
        inode_unlock_shared(inode);

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54cdecbc7539..6e7c77276d58 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3771,9 +3771,9 @@ static int ext4_iomap_alloc(struct inode *inode,
struct ext4_map_blocks *map,
 }


-static int ext4_read_iomap_begin(struct inode *inode, loff_t offset,
-               loff_t length, unsigned int flags, struct iomap *iomap,
-               struct iomap *srcmap)
+static __always_inline int ext4_read_iomap_begin(struct inode *inode,
+               loff_t offset, loff_t length, unsigned int flags,
+               struct iomap *iomap, struct iomap *srcmap)
 {
        int ret;
        struct ext4_map_blocks map;
@@ -3900,6 +3900,12 @@ int ext4_iomap_next(const struct iomap_iter
*iter, struct iomap *iomap,
        return iomap_process(iter, iomap, srcmap, ext4_iomap_begin, NULL);
 }

+int ext4_read_iomap_next(const struct iomap_iter *iter, struct iomap *ioma=
p,
+                          struct iomap *srcmap)
+{
+       return iomap_process(iter, iomap, srcmap, ext4_read_iomap_begin, NU=
LL);
+}
+
 static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
                                   loff_t length, unsigned int flags,
                                   struct iomap *iomap, struct iomap *srcma=
p)

The github link for the changes are in [1].

Thanks for your patience with this!

[1] https://github.com/joannekoong/linux/commits/iomap_simple_dio_iomap_nex=
t_ext4/
