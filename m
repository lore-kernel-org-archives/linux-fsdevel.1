Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4736C5AE;
	Sun,  6 Sep 2026 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695529; cv=none; b=mXSk7wk1b7vgl8Ob+QVqBnu6oYPr0V+2ZOG+7rYbZUfygsCbCLYmcBOYHSL/x/ZOUKLa4t1ryCWBr2BJChk08rATlqEPneZ80bdu5nffCOTNk4CevoBqN//BNmymI22wDftYx7flKHfaZ2HAJjj/RAbPZQs0JLIfokh0rkb7im8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695529; c=relaxed/simple;
	bh=tlMfm4phO1UIuyZTeTiMNg6FsXbMxsNSHLiZQt/uw5k=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=LJ4YFTv8j8GvVzrQDTXw2SL1u2ZPbpO8wJMcGb232gtELz9eMDpfdLGGRgoTsFer8HptCFAJppV4UnQnfvcEvh1zPBYY3WQWBJ++fAvjL7QJ3oyZIix55O5f27MQPJ6B6SpYTVGETRo/6C7Cv50QH3My+jexqGRdrvQXqxLL38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=GphGd2I8; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bAxWjMjB; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="GphGd2I8";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bAxWjMjB"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788695525; bh=oz+HE2ETYucJKULh+WvxdLZ
	m/16AU54giBU3BvlUsMQ=; b=GphGd2I8s9zg3Ti3H16dO7mZVpk/QbyktYq5FJmmbtZ3CaiBhx
	IWZwyKFLCzrim4DmcF+Ct1z7xcBVdXMbLjiTPTAwlcIP+EKRBIMU2h0//PQnstLWMLAeUSmaFXK
	dv2gMQNuXCIkZ3lpT75kI+yXA3pq8StgLzvoscVJRYsKHDULygv8Wy6AjtTf9OcvEzEWFEtB+d/
	VjBnLOt0EPCFGs32wo1WxkI+AyJbt3kXJBEUuquUCiJ8ECga7QtxZpSwHDhsFLlAJJy9Ubk9/ul
	tThflo39/W4RzAmlhY0yR8ZF83PMTj2vRBwOTxP7dJ0RvvvUXraQFwouPmMsVFRMeZg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788695525; bh=oz+HE2ETYucJKULh+WvxdLZ
	m/16AU54giBU3BvlUsMQ=; b=bAxWjMjBEWJ8LgQVplPKKgKURJG5ivbbmMWXmnFgHjIwDZVbiU
	/tNeomZmHIwS8wVc1R21jK75gnlQ7NYKYsAg==;
Date: Sun, 06 Sep 2026 12:52:04 +0100
From: Bradley Morgan <brads@mainlining.org>
To: norbert@doyensec.com
CC: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_nstree=3A_check_listing_permis?=
 =?US-ASCII?Q?sion_before_taking_a_namespace_reference?=
In-Reply-To: <34C54FF6-AA8F-4124-9B40-C68EADB26D99@doyensec.com>
Message-ID: <F8EF9799-CDCE-435F-97E2-13B6CC92EC6D@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 September 2026 15:28:05 BST, Norbert Szetei <norbert@doyensec.com>
wrote:
>legitimize_ns() takes a reference on the candidate namespace before
>may_list_ns() has decided whether the caller may see it. The
>__free(ns_put) cleanup on the denied path can drop the last reference to a
>mount namespace while we still hold the rcu read lock, and put_mnt_ns()
>may sleep there. This is the same problem commit 2ec2aff3c8e2 ("ns: make
>sure reference are dropped outside of rcu lock") fixed for the put_user()
>path. Neither ns_requested() nor may_list_ns() needs a reference, both
>only look at the namespace type and at the caller's own namespaces, so do
>the checks first and take the reference last.
>

Great catch!

>Fixes: 76b6f5dfb3fd ("nstree: add listns()")
>Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>---
>A reproducer is available on request.

Please? Or a splat, or anything?


>
> kernel/nstree.c | 10 ++--------
> 1 file changed, 2 insertions(+), 8 deletions(-)
>
>diff --git a/kernel/nstree.c b/kernel/nstree.c
>index 6d12e5900ac0..831f279d174a 100644
>--- a/kernel/nstree.c
>+++ b/kernel/nstree.c
>@@ -533,19 +533,13 @@ DEFINE_FREE(ns_put, struct ns_common *, if (!IS_ERR_OR_NULL(_T)) ns_put(_T))
> static inline struct ns_common *__must_check legitimize_ns(const struct
> klistns *kls,
> 							   struct ns_common *candidate)
> {
>-	struct ns_common *ns __free(ns_put) = NULL;
>-
> 	if (!ns_requested(kls, candidate))
> 		return NULL;
> 
>-	ns = ns_get_unless_inactive(candidate);
>-	if (!ns)
>-		return NULL;
>-
>-	if (!may_list_ns(kls, ns))
>+	if (!may_list_ns(kls, candidate))
> 		return NULL;
> 
>-	return no_free_ptr(ns);
>+	return ns_get_unless_inactive(candidate);
> }

Fix LGTM, 

+ CC akpm, he tends to look at fixes in kernel/, if brauner wants to merge this then that's ok :)

> 
> static ssize_t do_listns_userns(struct klistns *kls)
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
