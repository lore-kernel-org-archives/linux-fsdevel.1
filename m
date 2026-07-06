Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF9378D71
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305099; cv=pass; b=j+sABic/FOt8dB+Jht5TlFeKfro/jPeyomiPt5d4UEREn5YwUys9efhxWiO2SFfAUGr93CPO5VUfznVLKUmXFP3LTybDGcwxylCnjpTo3Iq01JL44YhPyQcQMm17N5iMwajcztfCA4XZMNkUtgnTi6ModupEsbpegIhR92Io1LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305099; c=relaxed/simple;
	bh=n9TNeAQbgI8UxjwXpE8Z4TjGdt+dY786AbaS43p6XAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVoT/XN/oYwViXxy0E90PHsOaxe0eGnbxNsuv+y5jvYwf3H5qwM9dtvzRHaO7GdNqcjYNfilh2CsuyklLOdxto/TWs9cNQwI9dj2p+d2S0xJS6QVHL2X9F87UPx5MPU4+D3fazLoJOQEXhXHP47ctmYJD0B93lC//ZKG0MJlxLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS/lQBCN; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS/lQBCN"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80bd5b5b3afso16155207b3.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 19:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783305097; cv=none;
        d=google.com; s=arc-20260327;
        b=TXPBwFb9J/5DAKyFcT7InV7tgFsnNlewkXM1jT4kKCf3jiUbwJykmIiWmtBc2s/kKA
         FrBw4ENMWg+tva2BCEPv+XegeOuofK/myUEyR4zI9twy16dDQcRz+2sPTE1G9VQEFADi
         +aFJE1jzco/ZfscxVoYIZnYAUBhv/m9mHqo6SdO6Xzr2oGQp8nB5DXXTMKRXISDeucuH
         J8EndU9nJiD7VMu5kiDtLqHBGhjvMxpAsDRdjtpjjGY47wKczWR3L1YJTT3C/hMlIRQL
         wOvXwVKd/KAeiXinY/CGVXIGIzBGgnttmN8S7NAgtPD2HxjtCRPS4VYds+T/TjXnwyF7
         GpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=boftlstDcYrBJu7Iu482+D0cKVytNFUrB+cQh+eW748=;
        fh=4xPotoCTH1FED8oAISnXa8vgo2JYKpwRJZlVoqbtMmw=;
        b=jQuayWU2Q9X9+i78LRwwXwWOsl09HDrAFzkbvFMTKKELcnZOOgAOTxjEGmAqJI5Usi
         CszrVUHnq9jwmUF1gTCROHhylMzVwn0uY++nmjKuRa7QIDv3BThMdeehOno3zzhrthOR
         3UT6LuudHSIptblCrIPoNdxbGbvtKRAFq8c+h4lznFeFyE6dqCjNi+aBczKfhEaVBlZM
         c6iLEACSTqr4cFbYC3l7pQW/Dk3vDrI5vYSZjleVNEOBtOZ3S1zuDpKch580f3o29doe
         zbCW2udXFZz2t/+2xO2svo4HXdxQdbMfgegObF+2vdr4l1wLFjlZo4kM8DxgKg3i//Qc
         IN9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783305097; x=1783909897; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=boftlstDcYrBJu7Iu482+D0cKVytNFUrB+cQh+eW748=;
        b=aS/lQBCNezh0WdffuJAgxhAMTami0gjpH6W8b5J4k+tVkOv8rzvhLxYl6+jBKktFaf
         lQOr4YrNre7c5FjTzkzcIZ275l85aflgCGIlBE1oTZL9nXWjX1h6qyPhCzrKWFn5rqBt
         0KibuIbfQUnK9js3GME1VdIasDFuH8LfOmZGgQoE2wB+jQ+h9u/Ss+pUQ0daqEe5H9HG
         e7VqCzPA4v2mrz6Uqvt4si7cQfvO8v7ldTNQiw+Tn8BIBSwo8oxICmxv+pzxi0ywrWZI
         sJ5gx3ehMVkhoeW5eMBjqZE9Uvpgh5UnIJKuITX9khipynO0EpZi7OXH7ORjE4fYIsux
         VNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783305097; x=1783909897;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=boftlstDcYrBJu7Iu482+D0cKVytNFUrB+cQh+eW748=;
        b=eT2GrYnjtXmacmXBIrec7bFYQ9R6jjLgoZoL50PGuWNKgxYptMTP0rXsnaLvVsMDOl
         KOT/xjUxkA1gAwumoFMmPmuyt8ep0F717kPKYqnxz16pzr+R+oP4NYzuOYTazeGxgJFr
         eQKF0avj8PhA6TFspYK6yIKVQTSnQ5wdCLVfqIdKXlqDs3BqY6goZeA4jyKp957orvQ8
         Ob2yh9DVhA9JMA2co6x1dDC+89YtLVbPwEab2nOW699DLDkY2KeWCXy8kuZwRxwsZWgQ
         fEcsHBjengebsSkQnsFPTdRSwatXE4SYSeIc1ruLKjW8bhODjNKrxg+zMg0H6hemkr10
         ISng==
X-Forwarded-Encrypted: i=1; AHgh+RrNEwuavXqWZDEmcZZ1LAbEocWbLVK7pT1BS8OLZGIf82ySMpXmO9HfHvYG4IlD+V5kbGls/ZfNVhutiBma@vger.kernel.org
X-Gm-Message-State: AOJu0Yz35oePbZjnJ8dmGS6GVPV+PT5cFQYodKj3zcSJet2OeUBpccwA
	u2MuUJS9+dIUeMrND2rlCj9J4gvNkasSBXKOID8b6a1Su6FU/SuavpJoOyoKXdDB6DI/PLb9eCK
	nxCnVJsK5Q4ZnXLuGlLUr8Q6NP1d/s9EF4ExLRJX0dw==
X-Gm-Gg: AfdE7clwSfcJPDgWIDw/4UlkS7EUKwBD54TTBBFgJPDFW18Ibn8HOV8+b9VWVkOHCZy
	GAmje0EDCmTTWNdG+LJ1/P5eo4t/JPIhvcwpd31fX7HM4tLB32EfXkA4r9uOqlxNSL19r1rZgGW
	ZhUkjLC3IpbTVav5rhuGD4hsMiU3kKqqmvjrvqebb+OHotShKjMqq+x5EDq+8JfZbWKYKKFMMBY
	IlarMrP906J19UN0fyGl4Py+aZgIU9/Edzg8sIm26RGLs+9zDqG3W42hoi3LZIhYAFpST9wgMU=
X-Received: by 2002:a05:690c:660f:b0:809:28e1:d50c with SMTP id
 00721157ae682-81737c36470mr93913467b3.26.1783305096874; Sun, 05 Jul 2026
 19:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702161710.2606853-1-zzzccc427@gmail.com> <CANFS6bY-GKojmuLMRKoh9r83iHT7_wQQM=SKZH3vB88QFzg11A@mail.gmail.com>
 <CAFRLqsX6CM1D3F4AvYSNj3rT8YbOn2Ah4M73B0W1FCUVNOdj3w@mail.gmail.com> <CANFS6bZY3yfocFbAyg2FQqijQ4jjyXA-fprE-eQMcU5xKOS+eg@mail.gmail.com>
In-Reply-To: <CANFS6bZY3yfocFbAyg2FQqijQ4jjyXA-fprE-eQMcU5xKOS+eg@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 6 Jul 2026 10:31:23 +0800
X-Gm-Features: AVVi8CfYBclYVT9YnwILG1DbmyOeSEf70QSTp-RxzGFh4RZcSPyuoqdhc3XKprs
Message-ID: <CAFRLqsXw9FD60pvU6-_JKfXMBqcfvagszUuTP4VtiN3ZNwzbfw@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs: serialize attribute-list replacement with lookups
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi, Hyunchul

>
> Could you summarize what issues were found and how they were resolved?
>
> There are so many changes in the v5 patch, it is difficult to understand the
> overall picture.
>

Thanks.

I attempted to create the following summary with the help of LLM.

Compared with v4, the main changes are not for a different original crash,
but for the locking problems I found while trying to validate the same
attr-list lifetime fix with xfstests.

The rough summary is:

1. generic/013 self-deadlock

   The stack you reported showed a path already holding attr_list_lock for
   writing and then re-entering ntfs_attr_get_search_ctx(), which tried to
   take the same rwsem again for reading.

   In v4 I tried to address that by adding LOCK_NONE/nolock paths for callers
   that already control attr_list_lock.

2. Nested index/$BITMAP locking

   Later, generic/467 reported a recursive locking problem.  The nested
   directory/index path propagated nested attr-list locking to the index
   search context, but the later $BITMAP attribute inode open still used the
   normal ntfs_attr_iget() path.

   v5 propagates the nested lock mode through the index open and the related
   $BITMAP attribute open.

3. attr_list_lock vs runlist.lock ordering

   Some paths reached attr-list lookup/update while runlist.lock was already
   held, or updated mapping pairs while still depending on the runlist lock.
   That conflicted with the intended order:

     mrec_lock => attr_list_lock => runlist.lock

   v5 adds explicit nolock/runlist-locked variants so callers that already
   hold one side do not acquire the locks again in the wrong order.

4. Mapping-pairs update paths

   Some mapping-pairs updates needed to be moved out of runlist-locked
   sections.  v5 snapshots the runlist where needed and defers mapping-pairs
   updates in write/fallocate/writeback paths until after runlist.lock is
   dropped.

5. Propagating the lock mode through helper layers

   Once the search-context lock mode was used to protect ctx->al_entry for the
   whole context lifetime, related helpers also had to carry the same mode:
   ntfs_attr_iget(), ntfs_index_iget(), iomap/aops, inode attr read/write, and
   some index/reparse paths.  This is the main reason v5 became much larger
   than v4.

So the high-level picture is: v4 fixed the first obvious re-entry/deadlock
case, but wider xfstests coverage exposed that the lock mode had to be carried
through more NTFS helper paths to keep the attr-list cursor lifetime and lock
ordering consistent.  That is why I sent v5 as RFC rather than as a final
patch.

Best regards
Cen Zhang.
