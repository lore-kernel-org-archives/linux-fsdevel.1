Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FA3E1D1A
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688931; cv=pass; b=j7/488U2mpIXRzdQC33E20UwbIfNsLzrwT2KTOKUXAGHra8XXNLX8gD6U4eKTzMWPiMS7wEHnVQCyOV2OruEsqNyL8Yy9xigWXOMzGZpWOfr8hwUw5NG6MnQvCdYgKiE9SOdL4XmHx4CL10FFSuJD5HFfrBWZ94G8KA+znETagM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688931; c=relaxed/simple;
	bh=Pr5ObivNdgC6TpXZVCnYFfdYZPpZOxjA6yMjAIcM9dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qi22lm/YzEaSdi8fpKfvb4Hr6S1Jy8YfNGcFc+oXjfqEW9/LI86d0CyIozFo3n7Y6a3QjilQ/HkDF3lrCZTLdmmjWSMhqFYLfiRykhbsPC/hcCSBoZWiBHYmUO+8es3hGrt2db11gGJeELbl8drw9uxZSklr4Pa/c1c+dLVKSYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvEmHdbc; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvEmHdbc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so15504425e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 06:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688927; cv=none;
        d=google.com; s=arc-20260327;
        b=CcC3awazm1sBa57jkjDfWo8RFKB+2CVj29aTIh1sztdbmXuuWRaO1VZMM66ve0d0EN
         rT23MmvZ0IVon0EhkahWyVl2k2BfcH2OuKkLnPHHtCKSZlsjAK9ps7Yd7CzqLDAacyeO
         AAl+6YT26ydzK9/opVTO+DdoPH7RVVvaAMU7A9NABfSgL9Qvp2UvAOGFjO8il2Cl2hPh
         +ecGnC4D4j8sToFYdCfhuA8VKE0Zc4ylqdIg8QEEjf7qORFkww8ORgK9ttWEjh3vNO53
         eUe/pZXL8C/WRPTIq+fz7n1YninAMIegy5lDvpPG06Jo1gzyDHdSIkH6JzBH5eiLf6zR
         2uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KO35IpzQU2wUiVLnR02rlEk4h+IQIikt7twWTAwFAKQ=;
        fh=CgrIep4U0bcuM6/mhaaxittJLRP1ynJ9ooloXfAcjcc=;
        b=brAnR0C2TtzkkHEJzfZ3Kjbpz1ZE4l1L+b560yhdGQF+LqaMeWj/tSLObkAhJjorXB
         DcdJ8s5FtlPHCspdweewNdXSRJfoCP4gJlxWf2HsZjNUm59XN5E83hI1YKWKV5D0HmC9
         CLzEtH+e27skcw5x9rHJqC3LdSNqqou3pwbJpmSCvhX4fjUjz+Mq5FS+2U2qB3AmT4Qr
         GL4uWiklaE8KvlF1enU8lLJDK03+/oO+39nn87sfCwG+3VBXWAF5ScmNlW6CIJ+Tpq8N
         VBCgA2CQyiqATVjJrNZKoUe1SH96PzZ1BV1moWpvLilwHah86BDK3stILHRWbuaLGMAQ
         LV5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790688927; x=1791293727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KO35IpzQU2wUiVLnR02rlEk4h+IQIikt7twWTAwFAKQ=;
        b=EvEmHdbcZDRHlEJ1LoV5GlDXcMmhPdyd0VSyzRrMHlI6gmcvwvnLcqcWWim2wZkPMQ
         6ZMcYREQOZR8VX+PYbb4a0Fj1+5fZVGQM6Aid1DH80mbLCbc1jWrRNSN3Ac3L/3Q7BQn
         uSlp02A8tYtW0MVceWT5UhlV0VVRb1gNZLVVzTG21ibrkkNdLa0DKYm1xCD58HVsaiMh
         46YsaIkQS0T8gWe0XcIqrczCr2fQywNarlVffqqhl7DAEF/LeFZ2TNpWdlmcvBMG94Qc
         RqBzigkbtX6H2f7/Pu6jZejNTf/xb2ZGe+8t7WQyLVQ7BbwLozY3ma964vcsmQH21Sm3
         wNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688927; x=1791293727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KO35IpzQU2wUiVLnR02rlEk4h+IQIikt7twWTAwFAKQ=;
        b=BzldUXy5nstURfHyctmxVZN2ZNkEHk8prilC4DwsOS7KHtju5ojoUuoxbyCFzWo/x4
         zfMKoKLHApCR0pZhMfxz/DYbaF4wCiS55k+M6sRuOnm59S4dcSr3eoIhu9Eb1M/RUyvd
         lDmSsyYbw9Zu5bIM30x13HhgUBl4ZnKPwa4si6uQmxLupPxaALKDHeXTdUybmlw1Mekp
         qChqFFDmDOapZLFGgzJcP9udVxu6YIVxRE12WtbcZK2rXR/PAkJ+SLs1GImZ3MwbxFKy
         L8CMjj1/5t9IKTAHDSmEgYyK6eP0uWQOuoulOyLbZlx/UhoyJnmcmodnrFK1EDMgF2nx
         1iLg==
X-Forwarded-Encrypted: i=1; AKwUvBxVwOeF6/FJXdwlG/GozL0BPLccDnzDwyhcMblr0XrNRHd0QU0CEtdJdckfYtTYZzmpXN4kCZ+A7UMX5njQ@vger.kernel.org
X-Gm-Message-State: AFuF++m+UOwny2dvH73/Hr2G+Xee4yeV5lubj6XtwFan8VhvU5x7ZPuB
	D3Ua5gBId5DeLmB3TJQ3MLkAHnOXbv0ZLkbI4xqdPQ1KhOeAdUfQpYc9mE49KJWc+b1hANpDBH7
	KWV3gMQ6rTosjwM3YZ02x1Ja8tJgUMI+G4ZOn6k2+
X-Gm-Gg: AYBFou1ZBpAQSvf73hyOsMOzv+TxZzVDgBbQzy9RFoTlfO7qhoHLv1uZ46ZyuJBIpSv
	s725RpBnQ+9Y1jeCpAcLUbxJGbPNrSsRbOpveeHW5Py/QaSaO5iXjBUGm1anttgYifyn0L5ywQc
	YxeSxwi9bHvPsM0lHvn1gaj0KS+KrFbzW/jDL7IV0wFONPNyvTtgjPQfBczOdyk6R4C1XUzAegV
	wxv8xQ2H6LB/AdnTyXDXr8pa0r29KzAfWN515IFp9KpA8OGPKhx4BxOjIuyCKtZbbXTTFadXl3h
	7ZQesA1xG1jo835vMJcfIeGtcTutOeHJgwxospj4E/cUuxxCZ101RBSvjF1y4zZGgYmi2MauzIW
	6T4UxCyAYZHtWcxETrFcaNkDLcvvULa8aGBDff8lag4xm0Ul3OUXh
X-Received: by 2002:a05:600c:4e08:b0:49e:817a:ca7 with SMTP id
 5b1f17b1804b1-49fe66d05cbmr252109515e9.8.1790688926718; Tue, 29 Sep 2026
 06:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com> <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV> <art7swUNAa3AyUrL@google.com> <20260929132839.GA989762@ZenIV>
In-Reply-To: <20260929132839.GA989762@ZenIV>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Sep 2026 15:35:13 +0200
X-Gm-Features: AclHuK8Z-kW-zwNhccfDW8-lP45SgDWDrvmNfYKPjY5D3ROZthqWW7EWiceXvYE
Message-ID: <CAH5fLgis-9ibYAEK-shQtwg_08Le-JDYChS77LugEhgZ=T+z8Q@mail.gmail.com>
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, 
	Georgios Androutsopoulos <georgeandrout13@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 3:28=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Tue, Sep 29, 2026 at 08:49:55AM +0000, Alice Ryhl wrote:
>
> > So, I previously wrote some code that could invoke filp_close() to clos=
e
> > a given fd ... from a workqueue. This was in the scenario where the
> > process dies and the usual cleanup function gets called deferred from a
> > workqueue instead of from the ioctl like usual.
>
> Huh?
>
> 1) filp_close(file, NULL) doesn't do _anything_ to any descriptor tables;
> the only requirements are that it should happen in _some_ thread context
> (workqueue is fine) and that caller should not be holding any locks that
> might be taken by ->flush() of the file in question (for a workqueue
> callback it's fine as long as the callback itself is not holding any
> of those).
>
> 2) any caller of filp_close(file, files_struct) must obviously guarantee
> that files_struct won't be freed under it; passing current->files from
> workqueue is safe in that respect, but obviously bogus.  Note that
> descriptor table in question will *still* not be accessed; it serves
> only as an opaque tag that identifies POSIX locks (and dnotify_struct
> instances) related to the descriptor table in question.  IF you have
> just manually removed the file in question from descriptor table
> (file_close_fd()), you must call filp_close() passing it the same
> descriptor table while that descriptor table is still guaranteed to
> be alive.
>
> Rationale is memory safety, actually - for POSIX locks descriptor table
> serves as lock owner; the reference is opaque, but we don't want to have
> it outlive freeing and reuse of the object it's pointing to.  So anything
> that removes some file reference from a descriptor table is responsible
> for corresponding filp_close() call done *before* the descriptor table
> is gone.
>
> Note that we only need to take care of the reference we remove from
> descriptor table; files_struct destructor will call filp_close() for
> anything still referenced from it.
>
> Places where file reference is removed from the table:
>         * do_close_on_exec(); filp_close() called in the same loop as
> clearing the descriptor table slot.
>         * do_dup2() in case the new slot had already been in use;
> filp_close() called just before return.
>         * file_close_fd_locked() callers. Three of those call filp_close(=
)
> as soon as they drop ->files_lock (close_fd(), __range_close() and
> io_uring io_close()).  Remaining caller (close_fd_locked()) leaves that t=
o
> _its_ callers (binder_deferred_fd_close() and its equivalent Rust-side).
>
> Again, normally both removal from descriptor table and filp_close() are
> done by the same primitive...
>
> > In this case the correct behavior was just to do nothing.
>
> ... leaking an opened file?  IDGI...
>
> > It was a very easy mistake to make, and if such mistakes lead to null
> > ptr derefs or worse, then I think it's worth doing something to reduce
> > the bad consequences from this kind of mistake.

Sorry I mixed it up ... the code called file_close_fd() and then
filp_close() with current->files. The important call here is the
file_close_fd() one, not the filp_close() one.

Alice
