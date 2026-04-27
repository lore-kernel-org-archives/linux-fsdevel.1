Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F305312803
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294324; cv=pass; b=Gfix7Ge/YaRrK9Dpc1mFAZGNOPiozmROrMo76TTdxeZUGoOQ7ekkXs27iVho0COndRYtr8uQiNTiuhUQfcEZZv+WKsAcx/HyMBI5FLi6ZusVPwrlkfWGlvMnNIbb7ulBfmi5MwGgRbIqEbs3cbtWucQyBNGfH5s96gVbuAQlBwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294324; c=relaxed/simple;
	bh=EG/J4UGh3eCwSuRcJEkJEJxR7JlBLrl/6GrVtUQBlGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTeXAqcXwsN1IAzcnQYto1EmolnpVPqGPQKevpqDrFxmG9TmXwI8nl40X5QXtZTVw9jm8Q1uADOLn+eQ+2QOw44CmmBlqF4pbSIJqZyHvodyG2Knom8x60l9En5qEHyuwS3nGQuxc/0+7i2C5OA25QYvCGivBKrz+jOHlihH5nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0Yf1hgu; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0Yf1hgu"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7de4e6c5a30so2926475a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 05:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777294322; cv=none;
        d=google.com; s=arc-20240605;
        b=KM0aWJJUAHyWI0yrt2hsPXG6iMwu6VtqUWb5aJby1qQKlfG/hk0wUpAGXo4DEtWNkE
         Tfn21u3qXFyg8h9W7u0w8oUcqd9O1tw99pGamUG4rUE6fOqq6S08tH7Q97ICHHyJ5Za7
         KXDDrhST10WQVuiNLq3i8/CrsxxU+9gfAoK7+75/XVUheilI2WgynbMPc2obomvkvMij
         BzKFKjJ7Q9yQyVILOueIkOWId3TzoR3k/J7DM0L6VmakD50SO4d3yqatfQvaYB5XUAQ0
         04KLbLS6Jz4CDK0Z3lPU+8j0cajZn4Yo7QvAMcJJL4TtmGUHMH6DxvPv1xgj9/62H8fr
         4VNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EG/J4UGh3eCwSuRcJEkJEJxR7JlBLrl/6GrVtUQBlGs=;
        fh=UruxWHbumpFd+/MpnCcxY3RnDAQiyLjXGS40cA0dSLk=;
        b=kZ4NAjqcsKxjkUHXcjCJxqJ2hk8Pf/yeEyRJ0klW2Iui397Gnb9Cgqvf1gIR+NuuyG
         Ke7HyTKZA34AiD9UPyit0/QMyUbd5he0z9G9+1qxF+4O0kThzID2MyDkibsn6cTYlw2q
         7NEIUqKKA1Tdym/uSw/oD2DHFsQ2ioTSjQ/EVZL388wRJB70v15NrWCg0ViGTaTxp0uG
         F+d0q9L9Cxy+p73DpzbXuVqEDZAQQ3iQvt/XT5WO5cl4RjTn1KhUNE+hv+aIKKkGCvbp
         zNE9lgp+Q1FB1hKg67vJ6WoK7BF41Pe2rQj282xB7wgSDnARjNWItpkVEJMAtgdZ5xNn
         oT/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777294322; x=1777899122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG/J4UGh3eCwSuRcJEkJEJxR7JlBLrl/6GrVtUQBlGs=;
        b=G0Yf1hguojRHNRSWp8/L/SqogjcktqFRhjfMwoq15RF9QTNw0PXp/OhiaDgz+U+OPX
         0NO9fA8twaLKIluXBPJ6z2lnU7FnvZ1UzhxRYItS48JUIJzPC5jv+ckMkgJLX63hWe7q
         x4oEeDg5vbWUG4yE4R2Gh8gHrdS4BbgKvLS626KiDGYSTbgltrmcwvV2F6ElONsy/B15
         13LDOdKutasevGOaCmmzWXE/eF6U8AHJBNFkfv08BBo8izI0BaS6hs52+vyWmrZPmKq1
         8hz5zOewTuiY2V8hij5CwsqoG2c17ehs2CcEQ8wAFiwocmbto1ezbjOAAyZOeOfxQdyh
         G2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294322; x=1777899122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EG/J4UGh3eCwSuRcJEkJEJxR7JlBLrl/6GrVtUQBlGs=;
        b=QkRVNMtFfWNxLnfD9TEw32/7y8WJ3dJt2uzaUuPcwUIOYbEpw3TRt84UMJX62ZGJSY
         7YM3eJZbrAWxLMHdgbrn+mtjYFLNpzjuV9s0lqe8q8/dMqsxBQRvfcUZymIwPipiAUAj
         AgJdXhpE5hpak2qYaenVKi0/+8syA16zeV8LODF4sgZmyAfz1tkVy6mxB+uyrYwZj7I6
         XjDp6io+XLJyK6+wmsUYEUy5y/iIJBZxYRIK4Lc55DbcB+ZwFfLi+mBK5gjsJ2YXrFWv
         v+wzyVgucaaJRGz9p1qvuPDO2dUXT0Fz953s/W92h8El7584IMP2bNqsohzyIhBEGb6E
         LT3A==
X-Forwarded-Encrypted: i=1; AFNElJ8XBfgt243iTHHNWaGDFDdeaWz91+OrO7Ie+tuZDi0U7rVyMQmDACb9AvaegQgnuPW4Gc0/CJixLfmUEswR@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCnKuWqZGTusL4UKlgoVLcvQEIDZFOLKqZyKlx/5PpXb4sFTx
	w3pb1KgoVe1R/aXInT7AtY9X/FoUkJj78kZTL0YL/hdWNmjsAmf23CME4uENboraxnvMBvyLEQJ
	nVV1K3UgYQ7x0QwuGphRpc5ePCXTL5kg=
X-Gm-Gg: AeBDievpADGGkvdy9FIpZyKMbuaBuP84afJN81gr8o3lRGNw9dh//LQMIpkqDdlatJH
	/HghrU2GQNJMLrXklkLDGYXy6DJfsYOsfsz23uX+6GLNM1Bwj22fFcHzAyO+eYJIQbNNRqoRraS
	GIQYLpX9M4UPCKd9lxPIWfII/9oq3VqZDjYfncuHHvZCM3MCplfeO+sGi4vMTbZBOJy+Nu4xKUG
	z/nwpZewlrpThbOITlGUSj3PVe1L8JBTa64Y5fJhWC2Ek16stnp74WCBzAlxaIGRuTyeBa+i8Q0
	2nW6G+URtZ/iH8y7sexWcOhhprXjhgA=
X-Received: by 2002:a05:6830:6732:b0:7d7:f638:7a03 with SMTP id
 46e09a7af769-7dc950ff385mr27811030a34.10.1777294322529; Mon, 27 Apr 2026
 05:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2@kernel.org>
 <ae9ItoKFvB12Qimn@gondor.apana.org.au> <20260427-ledig-urform-4719da0a06d2@brauner>
In-Reply-To: <20260427-ledig-urform-4719da0a06d2@brauner>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 27 Apr 2026 17:51:51 +0500
X-Gm-Features: AVHnY4IScH53UaYPIaA6YOC4aKjN9vN_SqKv35Tn7RXxw0SMwzMLtQd2SMg1vdw
Message-ID: <CABXGCsPtb5dsz9tJFO-42qY4Cqd4MDg=m3g-9CshQgO00keyOA@mail.gmail.com>
Subject: Re: [PATCH] rhashtable: give each instance its own lockdep class
To: Christian Brauner <brauner@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	syzbot+5af806780f38a5fe691f@syzkaller.appspotmail.com, 
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 5:21=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> >
> > But could you please try this patch and see if it also fixes
> > your problem?
> >
> > https://patchwork.kernel.org/project/linux-crypto/patch/20260422213349.=
1345098-2-mikhail.v.gavrilov@gmail.com/
>
> Possibly, I don't have a way to easily reproduce this though.
> Imho, the right thing would be to have both: actual useful keyed lockdep
> annotation and - if safe - dropping the mutex.

Agreed -- the two changes are orthogonal: yours fixes the lockdep
class collapse, mine removes a mutex acquisition that has been
unnecessary since cancel_work_sync() was added in front of it.

On the safety of dropping the mutex: rhashtable_free_and_destroy()'s
documented contract already requires the caller to ensure no
concurrent operations, and cancel_work_sync(&ht->run_work) at the
top of the function quiesces the only in-library writer (the rehash
worker). After that, the tables are owned exclusively by this
function. The walks I switch from rht_dereference() to
rcu_dereference_raw() were already correct; the lockdep annotation
was just asking for a lock that no longer needs to be held.

I checked all in-tree callers of rhashtable_free_and_destroy() (and
of rhashtable_destroy(), which inlines the same teardown) for
correctness against the contract; none rely on the mutex for
serialization with anything other than the rehash worker.

I have no objection to either patch order. Happy to rebase mine on
top of yours, or for it to go in independently via Herbert's tree
once yours is merged.

--=20
Thanks,
Mikhail
