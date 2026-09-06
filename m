Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357A3F20FA;
	Sun,  6 Sep 2026 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695555; cv=none; b=CYJenFGjgwBSjZqRnZopq+VF+zpUv/md4XxkAkfPOUljQg1q/eUOuQrTmfS1mtLjF6rIX+SlyIPUVopJNQXf57dGwesU0OjGRVOjRNrSz9mCoL71F7fJ3Wg5cRuJpSlwq+U7jXhILoiOUDvUDU3YRHT40GwlKdrgC00t+CELVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695555; c=relaxed/simple;
	bh=37tI2xfup7pJiy4qJ4S6joQNy91RAyyKx/LlQdwuJ3I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qLg0QmTP/wQa9vwRvfW2fqKfPa8Wvyrxh8lAE5lWIdHzlTIg9iP3MczMLX8W2TFHskXdOiXC+juTEkH2+kyFLT8qA2P8XqHrqo3rt8HuY2jUDD5/Q2XxSNMhNAuGnUA0WKQ1QTMnghTmVHsZwU8hnCtSG4iWRzFVyzYKimh6VZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=oRiq/wPW; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=f1LA8EFR; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="oRiq/wPW";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="f1LA8EFR"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788695539; bh=8piyC2V8dzhCYBqiP/qtbtc
	lUofix7aPj7Un3/iLzAk=; b=oRiq/wPWYaWRQN4YaEroqK8W0+VxMeEMUv14dkNaMC3+Fi94Y/
	Sg3TEJhZ0ssLOH++szruXBYKqO7IhK+mcXKOncAMi/vAanlysn709cy8SLR7UXujtntfwD3c0/O
	dS5cZuza+SJKTsPVmcJ24NO1uS4V6eYCDPvkX32ifuwwVL1iq3mbIr/w890fHi2BMCwvAMES4Fq
	54KHgunWsqZa6NoAV5fh68qm1QZiVpxsbxYxZfr+M3vjLrVMbflbmAkfxX0Ok7ME9wMXAa8QYGJ
	ndc+72uuCCjv59yiz12UITo3pIrUt1os9UUSFBLAQ5k14HoUqD9QHy0unKB+ENO7GHw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788695539; bh=8piyC2V8dzhCYBqiP/qtbtc
	lUofix7aPj7Un3/iLzAk=; b=f1LA8EFRVEcaIGPQx+RlH/bwslZ6D8zfjMGWNAVGY0O5p7ekXN
	zi9rWxuez3/y3EnVF8JqhLU37J94UGnPvtCA==;
Date: Sun, 06 Sep 2026 12:52:17 +0100
From: Bradley Morgan <brads@mainlining.org>
To: norbert@doyensec.com
CC: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_nstree=3A_check_listing_permis?=
 =?US-ASCII?Q?sion_before_taking_a_namespace_reference?=
In-Reply-To: <F8EF9799-CDCE-435F-97E2-13B6CC92EC6D@mainlining.org>
References: <F8EF9799-CDCE-435F-97E2-13B6CC92EC6D@mainlining.org>
Message-ID: <14E429EB-5A23-4137-B209-169AEA008B80@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 6 September 2026 12:52:04 BST, Bradley Morgan <brads@mainlining.org>
wrote:
>On 4 September 2026 15:28:05 BST, Norbert Szetei <norbert@doyensec.com>
>wrote:
>>legitimize_ns() takes a reference on the candidate namespace before
>>may_list_ns() has decided whether the caller may see it. The
>>__free(ns_put) cleanup on the denied path can drop the last reference to
>a
>>mount namespace while we still hold the rcu read lock, and put_mnt_ns()
>>may sleep there. This is the same problem commit 2ec2aff3c8e2 ("ns: make
>>sure reference are dropped outside of rcu lock") fixed for the put_user()
>>path. Neither ns_requested() nor may_list_ns() needs a reference, both
>>only look at the namespace type and at the caller's own namespaces, so do
>>the checks first and take the reference last.
>>
>
>Great catch!
>
>>Fixes: 76b6f5dfb3fd ("nstree: add listns()")
>>Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>>---
>>A reproducer is available on request.
>
>Please? Or a splat, or anything?
>
>
>>
>> kernel/nstree.c | 10 ++--------
>> 1 file changed, 2 insertions(+), 8 deletions(-)
>>
>>diff --git a/kernel/nstree.c b/kernel/nstree.c
>>index 6d12e5900ac0..831f279d174a 100644
>>--- a/kernel/nstree.c
>>+++ b/kernel/nstree.c
>>@@ -533,19 +533,13 @@ DEFINE_FREE(ns_put, struct ns_common *, if
>(!IS_ERR_OR_NULL(_T)) ns_put(_T))
>> static inline struct ns_common *__must_check legitimize_ns(const struct
>> klistns *kls,
>> 							   struct ns_common *candidate)
>> {
>>-	struct ns_common *ns __free(ns_put) = NULL;
>>-
>> 	if (!ns_requested(kls, candidate))
>> 		return NULL;
>> 
>>-	ns = ns_get_unless_inactive(candidate);
>>-	if (!ns)
>>-		return NULL;
>>-
>>-	if (!may_list_ns(kls, ns))
>>+	if (!may_list_ns(kls, candidate))
>> 		return NULL;
>> 
>>-	return no_free_ptr(ns);
>>+	return ns_get_unless_inactive(candidate);
>> }
>
>Fix LGTM, 
>
>+ CC akpm, he tends to look at fixes in kernel/, if brauner wants to merge this then that's ok :)
>
>> 
>> static ssize_t do_listns_userns(struct klistns *kls)
>>
>
>--- Thanks!
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

Forgot my tag, oops!

Reviewed-by: Bradley Morgan <brads@mainlining.org>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
