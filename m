Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5F353A61
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765964; cv=none; b=mUBit80oXnjMyejBb6cGbAjOZx42dN+6ez7nhZmUHTeOmtv+bTJVv36fz073e45G5JFlS95U47bNeVPvuXZVXsXZCS6u/PUJTCSsGASuQNL7bjYe41KJ51Kw8/HMgdNWDJRff5R/umlt7kjM9/FXrXleiDD8ruRo0o8MM/cPsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765964; c=relaxed/simple;
	bh=ujXvH+QUggs2BjDxPVxIjBSKMpGsHF/e6uAyGUcwkjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MyQc6eiqRACBYcntokfwYFUnzOHmRDymQ+xYfh+1gNlF9zz0VacrIKnoYDLKQsE607taAgg2QoYc43vxtNcYDTPNC7cmjHcE81vjV6NrCPEmFkA48YiEoGPR0nIBa37a3BwIUFvgqknY1mgAAA/NjKxhzNA9HdLZRRatYlU1wkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L29GElRT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L29GElRT"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493bd1716b4so8199675e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783765961; x=1784370761; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JoGEUVDo62zcdMtD5EgM++hSQT8LOC5CKG+rJ8zo+lU=;
        b=L29GElRT+7+Bqmwtw0WRbtKhpaN+8z/6Vg+sfT/jO4pGoQ1wNEtYOXe7oq4mKc+n3c
         xFvXbIj7RLYZCfIK2ZD10YLgobp4fHDGhJQCMerqqGBUTp4gg9pMc8uI1JrgZj+esA22
         uaRJUIdyEnOFCsGLKZIMznQ9enbZGgtL9r9EC1sE96JGHQuuYextMMXsOV5oZIAG6EBF
         rljA7VBTGqHDCLXQoX5Gm8+J2NhzfGhHZmi/021hLo2uv2K60LcieWDXnS7vqgXTDJvb
         mrr0q7h/rGKzn94Hxgetmf/geP43+assra5mqp7OsqPkYNJ4nnXtyuhviMVlqym+yb1m
         hqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783765961; x=1784370761;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JoGEUVDo62zcdMtD5EgM++hSQT8LOC5CKG+rJ8zo+lU=;
        b=GlINU8pUfcu9CYUbpBf3vy8cR1IEp5DaW47ZYqOqazRlNuFDvbsbCKQyZOuuo4L10Q
         AJFFGc3Gj3FZgcaZwa1n8I5GvbKInhBvw65ax265ClJdo2sr8FuzPf08ZjGsz/wUonBj
         AjmkwLv627X4nGHMi7Xfin4oAbEP9SKaEcsR+V3DatSqADImo4PrOKXXMvedt6tvLVwE
         F1wTjpUINJ8WDJqLTTYG8GyaoksoFRwxPxdMnhRzdZEH81z2tuRwJQoM5YsQp7LsXXws
         +qNNiukmK5otmdNcnVA6TTo8Js3sQ229DzeKt4DVAUu8Kk5/qR9OVVoyYawLRDWvLCqg
         aZjg==
X-Forwarded-Encrypted: i=1; AHgh+RpN7V8aWXD9vTEpxLjDjq/AYyzy4UK/GJht96Z5vBVTG5Hb5yoOHg4vydhuqi6kCs7R4YWy8raalG1QGWNm@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqFlIJmRXhpYPvWrZzxPI0R9cH3Qe6LJ7sbgxePjziAO/eyZn
	37r06IXFi6LxLYOTqpSxtP+MKP8SutpG0hxO/0/HUsn2j3N+zz0/6vnHgcgT5YQkkLIhwT5Im4d
	DKlKthyOyIUlKSB1vQA==
X-Received: from wmht21.prod.google.com ([2002:a05:600c:41d5:b0:493:aecc:773c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f8a:b0:492:43d2:9e6e with SMTP id 5b1f17b1804b1-493f87e9bd4mr20378535e9.9.1783765961023;
 Sat, 11 Jul 2026 03:32:41 -0700 (PDT)
Date: Sat, 11 Jul 2026 10:32:39 +0000
In-Reply-To: <alGOptAAFXuHscmG@tardis.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
 <20260707-upgrade-poll-v6-2-4b8fae7bf1d9@google.com> <alGOptAAFXuHscmG@tardis.local>
Message-ID: <alIbx8oav01VLarX@google.com>
Subject: Re: [PATCH v6 2/2] rust_binder: move (e)poll wait queue to Process
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Christian Brauner <brauner@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 10, 2026 at 05:30:30PM -0700, Boqun Feng wrote:
> On Tue, Jul 07, 2026 at 10:43:13AM +0000, Alice Ryhl wrote:
> > +        {
> > +            let poll = loop {
> > +                if let Some(poll) = this.poll.as_ref() {
> > +                    break poll;
> > +                }
> > +
> > +                let poll = PollCondVarBox::new(c"Process::poll", kernel::static_lock_class!())?;
> > +                // Reuse our existing lock to synchronize callers initializing.
> > +                let _guard = this.node_refs.lock();
> > +                this.poll.populate(poll);
> > +            };
> 
> Note sure whether this lock is needed? SetOnce::populate() should be
> atomic, i.e. only one populate() would win?
> 
> Also seems we should have a SetOnce::as_ref_or_populate(&self, default:
> T).

I'm taking this lock because I want to ensure that losers only loop
once. The problem is that just because you lost the race in populate(),
it's not guaranteed that as_ref() will return Some on the next
iteration, since the winner of the race may still be busy executing
populate(). Taking the loop avoids this possibility.

With regards to as_ref_or_populate(), I point you to this discussion for
reasons why this is hard:
https://lore.kernel.org/all/aZLZbN5C3wXgt3kL@google.com/

> The rest looks good to me. FWIW,
> 
> Reviewed-by: Boqun Feng <boqun@kernel.org>

Thanks!

Alice
