Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019DA51EE09
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910132; cv=none; b=XC/3DI0X+uYU5DtXlptqotD/pB+26eF0k9gxEXzQ8kvcOjUozdH4DrbtsqcJ2o7d4tsdhF4hLm0n0RKFFm1xz9gcFJIb1tmMAinP5N2ssevQ9fwU55iFhmDyX9yJhgrBLW3BvSQQH5413n9xJ5hgNGlv47LV53JPJg4qrZAcLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910132; c=relaxed/simple;
	bh=NbCIiRtXJTnRZUP9mYVlK3VxT9xvOBQ/rJufox/zAsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7St7Vc3bhIeo+56dLBkGTEiQmqg43JR9hNOadv6r4AukrpIWa4QKGNfZ0lqHzl4pJ2A0ItiyW8pF5Vt2rIJxI9sVE+iGa9OiDXkWWBw5TyfzsJ4DmXXTc3Cl8WpP7ZQns0JZ+te5bJih0Vcng3/mC9yGgRl9yTccXlzNB86gsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6TKsz4Y; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6TKsz4Y"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-677c1fc082bso2479610d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910129; x=1792514929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQdBv1gZDU6OUiKnprGOjVbB9OTzfZlS3gUNqTwncjw=;
        b=c6TKsz4YqZT703ZaQcXqLOwY6z8532NzWxrbxfLrOJhSw9oxX95p7sR7ouVXh1gVEp
         Dzp89Kh0sME8CnzbrNjNAZIk7gK+y/3QaPno6g/esTjTIrwHtCpp7yota9eEABQJ4UWx
         DWwK2eYK89EhTCeKRhMbkTxzkseBTk5GtnXENp3bxxtU45CLC2cVkhdHG17HD6WyR7KG
         pGXSknGCErBMqwdGIfaf+FvL+JiQ1GEfhg3a+Wibvl5IzBLPKQobz5stpVJ8v7PIwsY1
         4a6Oj6LCDUOcuYRI7oyYfxZGFAj0Tzi8PEEjuSaji3cVp60Z8L8Z+59nebMNvpnHU5+d
         QNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910129; x=1792514929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TQdBv1gZDU6OUiKnprGOjVbB9OTzfZlS3gUNqTwncjw=;
        b=OrhkoUn8vCpaUqzrT4TXJz+h4kDDTGy2Bvko2RSg7JhmT4MTCKR0GWqrLniebGKmc5
         ltsOfJHr8A/9MeccuqSYaqu9pqFy2mmp0laBa3h4p8M6EEu0pSiiVEtiIh11zyv0c8aZ
         a4mlTus9EQBkA+6Sxa34YXmMSCqdsza9Ihb62u/ggFVsRLbQQ3lLUx1GXzOIz2cTD7I7
         NcXFkM38/bcbm+wH1wgEnhhMPpB/GAmeDCQExfqXsXgsPjc5Syen7SNYXkELIcNPXgAU
         S4rvzH5qityk3d8swiyO6+vQmnYS+wOIkbvsvjYtVoZ0/B4G7wBZcn2VeVhD1API1APx
         FOLg==
X-Gm-Message-State: AFq9FYJD7Sju2cHAQMnYGXiLqHiJG/hKlBCCgunzB0OHXpFhkIKFuthM
	n0WwATDZefg9DU+YdRmKMNpJ7Ebp6Cu+0fVegpieYB7BqBbBN1u3HeJV
X-Gm-Gg: AYBFou1s724b+Fsz5GwSMbKyGnW7fRMet6aNRjMhWWzJVgUjaIOj7UIK1LGqXdFhbcj
	fpIiKUb2+I5IxAXCvehqo2BZBR6fuC8EMYaQkxCANJQjfaSQEGB+prNEFKPHdmElyP22/Fjfj6h
	zS67DiCqmEos/6/8iwHeW9gCAn/I6ujGWMWZmivKom/iiZ+CWuSXGzIAFWlB36HoumCSP/+YH//
	a8YwHMOi5AYIRawU1KGcCzS3HY5vHgc100JXIrU/vLO+pUYnwqOlJ10WAeWdi65rdHdWfRjE/iR
	ZH1U8+HWO/IUr8LNFoh0zifmHmK4jfgPf8NUwllJFJ9M0AvZtdOZQlGksMH1v6vBSksbek+JhuN
	fekyKjmOZ6FOt+K6H9VY7yvvpbGks2IMQrRaMGCGrrsggYdWplmS2NdclxH3LAvwT+ZC3wyZMT2
	O0lut7qoHwL7GrYEsS466Z8/s97CfBzJzuAFxuh3Zv8bKcQh5jSvaELVHUR054GYS2jkxLOaIa
X-Received: by 2002:a05:690e:14c5:b0:675:3177:bc84 with SMTP id 956f58d0204a3-67936012666mr4188811d50.25.1791910129059;
        Tue, 13 Oct 2026 09:48:49 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:48 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 09/11] bpf: support "__uninit" iterator arguments in generic kfuncs
Date: Tue, 13 Oct 2026 12:47:58 -0400
Message-ID: <20261013164800.2906577-10-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013164800.2906577-1-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterator constructors are recognised by their KF_ITER_NEW flag, which
binds them to the bpf_iter_<type>_new() name and so to a single
constructor per type.  A kfunc that initializes an iterator from inputs
that naming convention cannot express - e.g. another, already
initialized iterator - therefore cannot be a constructor.

Let such a kfunc mark its destination argument with the "__uninit"
suffix already used for dynptr out-arguments: process_iter_arg() now
decides per argument, rather than per kfunc, whether it initializes the
iterator or operates on an initialized one.  Only iterator-typed
arguments are reclassified, so dynptr "__uninit" out-arguments are
unaffected.

The first user is the path ancestor iterator handover added by the next
patch.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4b3e1d4f8a80..062273f68dd0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8499,6 +8499,24 @@ static bool is_iter_destroy_kfunc(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_DESTROY;
 }
 
+/*
+ * An "__uninit"-suffixed iterator argument of a kfunc that is not itself an
+ * iterator method: the kfunc initializes that iterator state, as a
+ * bpf_iter_<type>_new() does, but from inputs the constructor naming
+ * convention cannot express - e.g. another, already-initialized iterator.
+ * Only iterator-typed arguments qualify, so "__uninit" dynptr out-arguments
+ * are not reclassified.
+ */
+static bool is_kfunc_arg_iter_init(struct bpf_call_arg_meta *meta, int arg_idx,
+				   const struct btf_param *arg)
+{
+	if (is_iter_kfunc(meta))
+		return false;
+
+	return btf_param_match_suffix(meta->btf, arg, "__uninit") &&
+	       btf_check_iter_arg(meta->btf, meta->func_proto, arg_idx) >= 0;
+}
+
 static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
 			      const struct btf_param *arg)
 {
@@ -8509,7 +8527,11 @@ static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
 		return arg_idx == 0;
 
 	/* iter passed as an argument to a generic kfunc */
-	return btf_param_match_suffix(meta->btf, arg, "__iter");
+	if (btf_param_match_suffix(meta->btf, arg, "__iter"))
+		return true;
+
+	/* iter state a generic kfunc initializes */
+	return is_kfunc_arg_iter_init(meta, arg_idx, arg);
 }
 
 static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
@@ -8519,6 +8541,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	struct bpf_func_state *state = bpf_func(env, reg);
 	const struct btf_type *t;
 	int spi, err, i, nr_slots, btf_id;
+	bool init;
 
 	if (reg->type != PTR_TO_STACK) {
 		verbose(env, "%s expected pointer to an iterator on stack\n",
@@ -8550,8 +8573,16 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	t = btf_type_by_id(meta->btf, btf_id);
 	nr_slots = t->size / BPF_REG_SIZE;
 
-	if (is_iter_new_kfunc(meta)) {
-		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
+	/*
+	 * Whether this argument is the iterator the call initializes, rather
+	 * than an initialized one it operates on.
+	 */
+	init = is_iter_new_kfunc(meta) ||
+	       is_kfunc_arg_iter_init(meta, arg,
+				      &btf_params(meta->func_proto)[arg]);
+
+	if (init) {
+		/* expects a pointer to uninit iter state */
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
-- 
2.55.0

