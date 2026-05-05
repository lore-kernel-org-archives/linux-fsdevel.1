Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E848BD45
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999935; cv=none; b=IE8ATG9ZQsEUGP0Ek1ZWenSQA61KZddqH1hjbwGxPlH3i+lR4jMAgXsI9/dTIO3kN0E7RzCVxtoaYL2qTQCcYhI8wXb+/IB5vZyAtfEd4A/0Imc9xK3LEKAfrWWSSPs0Yms4RWcAkEqHoltOhKNj6E7PR1ULO216Yzv8iVvtwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999935; c=relaxed/simple;
	bh=Q2y9qYIe4xb6XzvJzqRUbG4DQZuqOFlJBG5Ryut0oag=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jEtzAkrySLSY8TtzedCHALhzF8ftNNHgMN4ACf8EnWEuqpo86G6Y3dUEWFiDXGmTg01fWq0K2DeGfoMPoK58KLO3bl4cDck0CyKcl16ElzXYW5Z5oX5gsURXKCvR2/H7pUu4DLu5CQfXEHSl2EdWsJlNZ80JvuT1wbLidlJEw+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=oYY22rBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qj2PFoWr; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="oYY22rBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qj2PFoWr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 887E0EC001C;
	Tue,  5 May 2026 12:52:08 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 05 May 2026 12:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1777999928;
	 x=1778086328; bh=cBL0VqAshzowRySGU6XypZrE8dmyMlGu9E36GyU8SA8=; b=
	oYY22rBrSwAB+v6uS4OU3SeT8z1AkPb8qdK/lonK/SjunO88mJRNrz6/MqQ522Kw
	3qTm4HJmL0OOjIIy52nik4MTfhN2MuChDaeb5R+RxTGshCnru4ca282nFPInZV4B
	hPY1uS0a1R4aCRdu68U0IWMZkagpTo9o168IKBZB00zzxaTL8LmF8eFOiSkhMRkL
	mieeZ49IoFmlAzQC/ou4HMBMY5du7p5DM47fGAhE5teEITDbWKGDWHA1ShMI5JC+
	eycqf9knSaoGLzRhfML/w5oKJyxD/enHV7JLOCNu0cOTckbCYmzSne9l0jSreEbX
	K6STKQaMx2mMGfBDyXKL9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777999928; x=
	1778086328; bh=cBL0VqAshzowRySGU6XypZrE8dmyMlGu9E36GyU8SA8=; b=Q
	j2PFoWr/bnbyclLdtMLIz9qLmwhZ8YLvs+BzcRGjr7JhaJG+MSj/2zOfzCsnvuMv
	jZcQlQs0QuLDVk2Xqn+l4Ko1SevN35WimlV2jQ0AI4iOEi+XMO1OtJig1i1BHInJ
	Uv9/PBP7WjhadAnDETcbRFL/iUGwIMqUpINh/LHXTEPLRlTEJjk/dclGm+U1UQS3
	oIsZu9nTvr86+a4G1Q7sEJ9btAzNTjMw8nA2uqcpbYoUyegC4oxsY2z0Bn0NS/Yv
	0Gtt5xA2sW4ymLp8sSelaWEcnYIK1PY4GuZ6LSBQaJUZnp9MtbK2d5fzVWnyhKJS
	NGdafCwtPcB55Oi6SkYhg==
X-ME-Sender: <xms:NyD6aaooLB0_Gl1Zdc5g0ScViwdKEuQzZHohA6i6A50H3KUMbaGvDw>
    <xme:NyD6aTfgnNxczB0DPMXPOeFKsYvFwECytihoJLEOdMhhB5frFq4YacgVj1aW2-o4U
    0YSwEs91vsQgTTEZUz2K0ziaZM8bpw0jDF0lze5rtJmNz1pYxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtf
    frrghtthgvrhhnpeffgfffteelieelgfeijedvjeehheevlefffeffveevgeelffehjeff
    jeeuudejheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghl
    thgvrhhssehvvghrsghumhdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvggsihhgghgvrhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehhtghhse
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfhhsvhgvrhhithihsehlihhsthhs
    rdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NyD6ab2X1jywDLUgMTq0NBfJi_gpwHlEp0mj_Eig-Nhpm2QHB9ZUtQ>
    <xmx:NyD6aTDD6n_CxUcl_2mODcBuYQAU1FgIFJRBM35bRA0NDbHeYy4adQ>
    <xmx:NyD6aXeDy0jd8vw0oTfzFEzeLp8fPfsSWS5sxJ6qKINJAkLYnLxmvg>
    <xmx:NyD6aQ4l6THL29_PqbnASntvMj5Bnvv1d3VfNQ6PJLzpZTXsBYalPQ>
    <xmx:OCD6acJvvxrxTYwFkj2Kyj2LbfJlMUY59ydRsmVaSu7nUVwWMUgRwwiI>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AE25B780070; Tue,  5 May 2026 12:52:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMDuz2u8DR1N
Date: Tue, 05 May 2026 12:51:47 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Eric Biggers" <ebiggers@google.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 fsverity@lists.linux.dev
Message-Id: <7baedcfe-534b-49f1-b00c-a8280c2703c0@app.fastmail.com>
In-Reply-To: <afXCoGk2Bu9rBKvJ@amir-ThinkPad-T480>
References: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>
 <afXCoGk2Bu9rBKvJ@amir-ThinkPad-T480>
Subject: Re: overlayfs: verity validation broken since f77f281b6118
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026, at 5:23 AM, Amir Goldstein wrote:
> On Fri, May 01, 2026 at 01:14:54PM -0400, Colin Walters wrote:
>> Hi Christoph & Eric,
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Df77f281b6118 broke composefs's usage of overlayfs verity=3Dre=
quire, this was reported originally in https://github.com/bootc-dev/boot=
c/issues/2174
>>=20
>> There's some output from an agent run I had in the <details> there, b=
ut here's an xfstests patch that passes on without that commit and fails=
 with it.
>>=20
>> From 14231122bfd1e41337e4fb847acbbe038457c32a Mon Sep 17 00:00:00 2001
>> From: Colin Walters <walters@verbum.org>
>> Date: Fri, 1 May 2026 09:45:58 -0400
>> Subject: [PATCH] overlay/118: test fsverity lazy load through metacop=
y overlay
>>=20
>> Reproduces the regression reported at:
>> https://github.com/bootc-dev/bootc/issues/2174
>>=20
>> A recent change in how fsverity state was cached in memory
>> I think caused inodes not in cache to appear to have
>> missing verity=3Drequire for overlayfs.
>>=20
>> This test catches that.
>>=20
>> Generated-by: OpenCode (Claude Sonnet 4.5)
>> Signed-off-by: Colin Walters <walters@verbum.org>
>> ---
>>  tests/overlay/118     | 62 +++++++++++++++++++++++++++++++++++++++++=
++
>>  tests/overlay/118.out |  1 +
>
>
> Please use free test numbers below 100

OK, I can resend with that change if that's the only thing.


>
> Is there a kernel fix for this? please mention it.

Not that I know of. I did have my agent framework (opencode + combo of G=
emini+Claude models) generate one initially, but I intentionally didn't =
post it because the generating is ~easy, verifying it's "good" is anothe=
r thing and my C has bitrotted a bit (in favor of Rust mostly but I have=
 to deal with a lot of Go too).

Anyways, this trivial change works:

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 13cb60b52bd6..af8f6c2989ce 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1039,7 +1039,7 @@ static bool ovl_need_meta_copy_up(struct dentry *d=
entry, umode_t mode,
=20
                if (WARN_ON_ONCE(lowerdata.dentry =3D=3D NULL) ||
                    ovl_ensure_verity_loaded(&lowerdata) ||
-                   !fsverity_active(d_inode(lowerdata.dentry))) {
+                   !fsverity_get_info(d_inode(lowerdata.dentry))) {
                        return false;
                }
        }
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 7b86a6bac644..bfdf9310ee78 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1354,7 +1354,7 @@ int ovl_ensure_verity_loaded(const struct path *da=
tapath)
        struct inode *inode =3D d_inode(datapath->dentry);
        struct file *filp;
=20
-       if (!fsverity_active(inode) && IS_VERITY(inode)) {
+       if (IS_VERITY(inode) && !fsverity_get_info(inode)) {
                /*
                 * If this inode was not yet opened, the verity info has=
n't been
                 * loaded yet, so we need to do that here to force it in=
to memory.


However, when I looked at this more closely I felt the APIs are too conf=
using, and my Rust-ified mindset especially didn't like the side-effectf=
ul nature of ovl_ensure_verity_loaded().

So here's a much bigger patch that looks a lot nicer to me upon a quick =
local review:

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index af8f6c2989ce..9d3908666b7e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1037,9 +1037,11 @@ static bool ovl_need_meta_copy_up(struct dentry *=
dentry, umode_t mode,
=20
 		ovl_path_lowerdata(dentry, &lowerdata);
=20
+		struct inode *inode =3D d_inode(lowerdata.dentry);
+
 		if (WARN_ON_ONCE(lowerdata.dentry =3D=3D NULL) ||
-		    ovl_ensure_verity_loaded(&lowerdata) ||
-		    !fsverity_get_info(d_inode(lowerdata.dentry))) {
+		    !IS_VERITY(inode) ||
+		    IS_ERR(fsverity_get_or_load_info(inode))) {
 			return false;
 		}
 	}
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b75df37f70ac..4d23ff29a4c3 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -581,7 +581,6 @@ int ovl_set_metacopy_xattr(struct ovl_fs *ofs, struc=
t dentry *d,
 			   struct ovl_metacopy *metacopy);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
 char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *pat=
h, int padding);
-int ovl_ensure_verity_loaded(const struct path *path);
 int ovl_validate_verity(struct ovl_fs *ofs,
 			const struct path *metapath,
 			const struct path *datapath);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index bfdf9310ee78..99aa2312de39 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1348,25 +1348,6 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, =
const struct path *path, int pa
 	return ERR_PTR(res);
 }
=20
-/* Call with mounter creds as it may open the file */
-int ovl_ensure_verity_loaded(const struct path *datapath)
-{
-	struct inode *inode =3D d_inode(datapath->dentry);
-	struct file *filp;
-
-	if (IS_VERITY(inode) && !fsverity_get_info(inode)) {
-		/*
-		 * If this inode was not yet opened, the verity info hasn't been
-		 * loaded yet, so we need to do that here to force it into memory.
-		 */
-		filp =3D kernel_file_open(datapath, O_RDONLY, current_cred());
-		if (IS_ERR(filp))
-			return PTR_ERR(filp);
-		fput(filp);
-	}
-
-	return 0;
-}
=20
 int ovl_validate_verity(struct ovl_fs *ofs,
 			const struct path *metapath,
@@ -1375,7 +1356,7 @@ int ovl_validate_verity(struct ovl_fs *ofs,
 	struct ovl_metacopy metacopy_data;
 	u8 actual_digest[FS_VERITY_MAX_DIGEST_SIZE];
 	int xattr_digest_size, digest_size;
-	int xattr_size, err;
+	int xattr_size;
 	u8 verity_algo;
=20
 	if (!ofs->config.verity_mode ||
@@ -1398,16 +1379,9 @@ int ovl_validate_verity(struct ovl_fs *ofs,
=20
 	xattr_digest_size =3D ovl_metadata_digest_size(&metacopy_data);
=20
-	err =3D ovl_ensure_verity_loaded(datapath);
-	if (err < 0) {
-		pr_warn_ratelimited("lower file '%pd' failed to load fs-verity info\n=
",
-				    datapath->dentry);
-		return -EIO;
-	}
-
 	digest_size =3D fsverity_get_digest(d_inode(datapath->dentry), actual_=
digest,
 					  &verity_algo, NULL);
-	if (digest_size =3D=3D 0) {
+	if (digest_size <=3D 0) {
 		pr_warn_ratelimited("lower file '%pd' has no fs-verity digest\n", dat=
apath->dentry);
 		return -EIO;
 	}
@@ -1426,21 +1400,14 @@ int ovl_validate_verity(struct ovl_fs *ofs,
 int ovl_get_verity_digest(struct ovl_fs *ofs, const struct path *src,
 			  struct ovl_metacopy *metacopy)
 {
-	int err, digest_size;
+	int digest_size;
=20
 	if (!ofs->config.verity_mode || !S_ISREG(d_inode(src->dentry)->i_mode))
 		return 0;
=20
-	err =3D ovl_ensure_verity_loaded(src);
-	if (err < 0) {
-		pr_warn_ratelimited("lower file '%pd' failed to load fs-verity info\n=
",
-				    src->dentry);
-		return -EIO;
-	}
-
 	digest_size =3D fsverity_get_digest(d_inode(src->dentry),
 					  metacopy->digest, &metacopy->digest_algo, NULL);
-	if (digest_size =3D=3D 0 ||
+	if (digest_size <=3D 0 ||
 	    WARN_ON_ONCE(digest_size > FS_VERITY_MAX_DIGEST_SIZE)) {
 		if (ofs->config.verity_mode =3D=3D OVL_VERITY_REQUIRE) {
 			pr_warn_ratelimited("lower file '%pd' has no fs-verity digest\n",
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 6a35623ebdf0..4ccf2ab8a70a 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -68,9 +68,9 @@ EXPORT_SYMBOL_GPL(fsverity_ioctl_measure);
  * @alg: (out) the digest's algorithm, as a FS_VERITY_HASH_ALG_* value
  * @halg: (out) the digest's algorithm, as a HASH_ALGO_* value
  *
- * Retrieves the fsverity digest of the given file.  The file must have=
 been
- * opened at least once since the inode was last loaded into the inode =
cache;
- * otherwise this function will not recognize when fsverity is enabled.
+ * Retrieves the fsverity digest of the given file.  If the inode has t=
he
+ * S_VERITY flag set but the fsverity_info has not yet been loaded into=
 the
+ * in-memory hash table, this function will load it from disk automatic=
ally.
  *
  * The file's fsverity digest consists of @raw_digest in combination wi=
th either
  * @alg or @halg.  (The caller can choose which one of @alg or @halg to=
 use.)
@@ -80,8 +80,8 @@ EXPORT_SYMBOL_GPL(fsverity_ioctl_measure);
  * provides no security guarantee for users who ignore the algorithm ID=
, even if
  * they use the digest size (since algorithms can share the same digest=
 size).
  *
- * Return: The size of the raw digest in bytes, or 0 if the file doesn'=
t have
- *	   fsverity enabled.
+ * Return: The size of the raw digest in bytes, 0 if the file doesn't h=
ave
+ *	   fsverity enabled, or -errno on error.
  */
 int fsverity_get_digest(struct inode *inode,
 			u8 raw_digest[FS_VERITY_MAX_DIGEST_SIZE],
@@ -90,10 +90,13 @@ int fsverity_get_digest(struct inode *inode,
 	const struct fsverity_info *vi;
 	const struct fsverity_hash_alg *hash_alg;
=20
-	vi =3D fsverity_get_info(inode);
-	if (!vi)
+	if (!IS_VERITY(inode))
 		return 0; /* not a verity file */
=20
+	vi =3D fsverity_get_or_load_info(inode);
+	if (IS_ERR(vi))
+		return PTR_ERR(vi);
+
 	hash_alg =3D vi->tree_params.hash_alg;
 	memcpy(raw_digest, vi->file_digest, hash_alg->digest_size);
 	if (alg)
@@ -116,6 +119,13 @@ __bpf_kfunc_start_defs();
  *
  * Read fsverity_digest of *file* into *digest_ptr*.
  *
+ * If the file's fsverity_info has not yet been loaded into the in-memo=
ry hash
+ * table (i.e. the inode is "cold"), this function will read the verity
+ * descriptor from disk before returning.  This may block on I/O.  The
+ * function is restricted to BPF_PROG_TYPE_LSM hooks (sleepable context=
), so
+ * blocking is safe, but callers should be aware of the potential laten=
cy on
+ * the first call for a given inode.
+ *
  * Return: 0 on success, a negative value on error.
  */
 __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_d=
ynptr *digest_p)
@@ -138,10 +148,13 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct fil=
e *file, struct bpf_dynptr *di
 	if (!IS_ALIGNED((uintptr_t)arg, __alignof__(*arg)))
 		return -EINVAL;
=20
-	vi =3D fsverity_get_info(inode);
-	if (!vi)
+	if (!IS_VERITY(inode))
 		return -ENODATA; /* not a verity file */
=20
+	vi =3D fsverity_get_or_load_info(inode);
+	if (IS_ERR(vi))
+		return PTR_ERR(vi);
+
 	hash_alg =3D vi->tree_params.hash_alg;
=20
 	arg->digest_algorithm =3D hash_alg - fsverity_hash_algs;
diff --git a/fs/verity/open.c b/fs/verity/open.c
index dfa0d1afe0fe..4db71b396cdb 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -344,24 +344,48 @@ int fsverity_get_descriptor(struct inode *inode,
 	return 0;
 }
=20
-static int ensure_verity_info(struct inode *inode)
+/**
+ * fsverity_get_or_load_info() - get the fsverity_info for a verity ino=
de,
+ *				 loading it from disk if necessary
+ * @inode: inode with the S_VERITY flag set
+ *
+ * If the fsverity_info has already been loaded into the in-memory hash=
 table
+ * (i.e. the file has been opened), return it immediately.  Otherwise r=
ead the
+ * verity descriptor from disk and populate the hash table entry.
+ *
+ * Unlike fsverity_get_info(), this function never returns NULL for a v=
erity
+ * inode =E2=80=94 it either returns the fsverity_info or an error.
+ *
+ * On encrypted verity files, the fscrypt key must already be set up on=
 the
+ * inode (e.g. via a prior fscrypt_file_open()) before calling this fun=
ction,
+ * as the descriptor read uses the existing crypto context rather than
+ * establishing one.  Callers such as overlayfs that reach this path du=
ring
+ * copy-up already satisfy this precondition.
+ *
+ * The caller must ensure @inode has the S_VERITY flag set.
+ *
+ * Return: the fsverity_info on success, ERR_PTR(-errno) on failure
+ */
+struct fsverity_info *fsverity_get_or_load_info(struct inode *inode)
 {
-	struct fsverity_info *vi =3D fsverity_get_info(inode), *found;
+	struct fsverity_info *vi, *found;
 	struct fsverity_descriptor *desc;
 	int err;
=20
+	if (WARN_ON_ONCE(!IS_VERITY(inode)))
+		return ERR_PTR(-EINVAL);
+
+	vi =3D fsverity_get_info(inode);
 	if (vi)
-		return 0;
+		return vi;
=20
 	err =3D fsverity_get_descriptor(inode, &desc);
 	if (err)
-		return err;
+		return ERR_PTR(err);
=20
 	vi =3D fsverity_create_info(inode, desc);
-	if (IS_ERR(vi)) {
-		err =3D PTR_ERR(vi);
+	if (IS_ERR(vi))
 		goto out_free_desc;
-	}
=20
 	/*
 	 * Multiple tasks may race to set the inode's verity info, in which ca=
se
@@ -372,20 +396,20 @@ static int ensure_verity_info(struct inode *inode)
 						  fsverity_info_hash_params);
 	if (found) {
 		fsverity_free_info(vi);
-		if (IS_ERR(found))
-			err =3D PTR_ERR(found);
+		vi =3D found; /* either the winner's entry or ERR_PTR */
 	}
=20
 out_free_desc:
 	kfree(desc);
-	return err;
+	return vi;
 }
+EXPORT_SYMBOL_GPL(fsverity_get_or_load_info);
=20
 int __fsverity_file_open(struct inode *inode, struct file *filp)
 {
 	if (filp->f_mode & FMODE_WRITE)
 		return -EPERM;
-	return ensure_verity_info(inode);
+	return PTR_ERR_OR_ZERO(fsverity_get_or_load_info(inode));
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
=20
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index a8f9aa75b792..0ea8ef2348d2 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -136,13 +136,25 @@ struct fsverity_operations {
=20
 #ifdef CONFIG_FS_VERITY
 /**
- * fsverity_active() - do reads from the inode need to go through fs-ve=
rity?
+ * fsverity_active() - does the inode have the S_VERITY flag set?
  * @inode: inode to check
  *
- * This checks whether the inode's verity info has been set, and reads =
need
- * to verify the file data.
+ * Check whether the inode has the S_VERITY flag set.  This flag is set
+ * when the filesystem marks the inode as a verity file, and it persists
+ * for the lifetime of the inode in the inode cache.
  *
- * Return: true if reads need to go through fs-verity, otherwise false
+ * Note: S_VERITY being set does NOT mean the fsverity_info has been lo=
aded
+ * into the in-memory hash table yet.  The info is loaded lazily on fir=
st
+ * open (via __fsverity_file_open()).  Use fsverity_get_info() to check
+ * whether the info is loaded, or fsverity_get_or_load_info() to load it
+ * on demand.
+ *
+ * The smp_mb() pairs with the try_cmpxchg in set_mask_bits() that SETS=
 the
+ * S_VERITY bit in i_flags.  This ensures that stores made before the f=
lag
+ * was set (in particular, the hash table insertion of the fsverity_inf=
o) are
+ * visible to any CPU that subsequently observes S_VERITY set.
+ *
+ * Return: true if the inode has S_VERITY set, otherwise false
  */
 static inline bool fsverity_active(const struct inode *inode)
 {
@@ -159,13 +171,26 @@ static inline bool fsverity_active(const struct in=
ode *inode)
 }
=20
 struct fsverity_info *__fsverity_get_info(const struct inode *inode);
+
 /**
- * fsverity_get_info - get fsverity information for an inode
- * @inode: inode to operate on.
+ * fsverity_get_info() - get the in-memory fsverity_info for an inode
+ * @inode: inode to look up
  *
- * This gets the fsverity_info for @inode if it exists.  Safe to call w=
ithout
- * knowin that a fsverity_info exist for @inode, including on file syst=
ems that
- * do not support fsverity.
+ * Return the fsverity_info for @inode if it has been loaded into the
+ * in-memory hash table, otherwise return NULL.
+ *
+ * A NULL return has two distinct meanings:
+ *  1. The inode is not a verity file at all (S_VERITY not set).
+ *  2. The inode IS a verity file, but its info has not been loaded yet
+ *     because the file has not been opened since the inode was last ev=
icted.
+ *
+ * Callers that need to distinguish these cases should check IS_VERITY(=
inode)
+ * alongside the return value.  Callers that need the info to always be
+ * available should use fsverity_get_or_load_info() instead.
+ *
+ * Safe to call on any inode, even on filesystems that do not support f=
sverity.
+ *
+ * Return: the fsverity_info if loaded, NULL otherwise
  */
 static inline struct fsverity_info *fsverity_get_info(const struct inod=
e *inode)
 {
@@ -187,6 +212,7 @@ int fsverity_get_digest(struct inode *inode,
=20
 /* open.c */
=20
+struct fsverity_info *fsverity_get_or_load_info(struct inode *inode);
 int __fsverity_file_open(struct inode *inode, struct file *filp);
=20
 /* read_metadata.c */
@@ -242,6 +268,11 @@ static inline int fsverity_get_digest(struct inode =
*inode,
=20
 /* open.c */
=20
+static inline struct fsverity_info *fsverity_get_or_load_info(struct in=
ode *inode)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline int __fsverity_file_open(struct inode *inode, struct file=
 *filp)
 {
 	return -EOPNOTSUPP;
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/i=
ma_api.c
index 0916f24f005f..1eabb2d76961 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -213,9 +213,14 @@ static bool ima_get_verity_digest(struct ima_iint_c=
ache *iint,
 	/*
 	 * On failure, 'measure' policy rules will result in a file data
 	 * hash containing 0's.
+	 *
+	 * fsverity_get_digest() returns 0 if fsverity is not enabled on the
+	 * file, or a negative errno if the verity info could not be loaded
+	 * (e.g. -EIO reading the descriptor from disk).  Treat both cases the
+	 * same: fall back to the file data hash.
 	 */
 	digest_len =3D fsverity_get_digest(inode, hash->digest, NULL, &alg);
-	if (digest_len =3D=3D 0)
+	if (digest_len <=3D 0)
 		return false;
=20
 	/*
diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 21439c5be336..1910f4b3641b 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -204,10 +204,10 @@ static bool evaluate_fsv_digest(const struct ipe_e=
val_ctx *const ctx,
=20
 	if (!ctx->ino)
 		return false;
-	if (!fsverity_get_digest((struct inode *)ctx->ino,
-				 digest,
-				 NULL,
-				 &alg))
+	if (fsverity_get_digest((struct inode *)ctx->ino,
+				digest,
+				NULL,
+				&alg) <=3D 0)
 		return false;
=20
 	info.alg =3D hash_algo_name[alg];
--=20
2.52.0
