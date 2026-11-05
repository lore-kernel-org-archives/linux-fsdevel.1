Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897102;
	b=GD/bjI+zGMvDqTjPkg85FcdSQAo+T2Y1G7baRde0DQZpVikNV7z8r9h0aqtr+MuFZoK4
	 Yg9dszCzkgtoS1h+mjwH9+tdUOV5zmORqhKvEM6lcUfQXYcdDrVlHgKJYREhLag+ToACr
	 hAT+lf0AmW2mjPiVGQ394xDk9HdoVIuJJv6plS95WqaMrdRg9tbZpw0E2ZzH6lgraSkrY
	 9+wCjmZQPvIwpvbc6Xpjh7Vg2ibFRHsJMUAAQewDxYYYl0uuqr3x912DsR79hsINs+E5w
	 DzdCu2vbisqd46hntA3Sqg1RIRaxUS7d7EgObtCMT/1FU81SIe8iMLWfeZqvGUrqwtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=wdYtPMhw6iQb9Bu4pea/weFH8wbGNUV9dgjmliA9Fu4=;
	b=RPE3gZQdZ5QxVXfMYESIMfLiRdxoVk9nu4se+cuySmgR+0oa0Rqxak8nSlHmf49eRADJ
	 2Bm1VH+UhbYNY2vWMeKRJY4nQ9HtNppMoJXBw/oZ+VBUDavxGywnLEbzGMKh5kSqT3J+J
	 3NoXkNeqLRQJkwESswQ3T23ANYITXBGqdSaW9PDJUoTn8eKGxDMCq9/FCXHZsDY760K0E
	 4pbMd2NpXNnfuiA1ei/PKYar3mEjFP/mj77TnN+S6B4RtZhoBXwWBQ8A8280b3AfgNb3W
	 IH19HvcyQQh8Fv6Tv5uEcDeFIEA5r3vEADgzDh0d4JPhCaln3d5vqCyfhUaNqLGvnsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GeWQn8+z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AC606A333
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 16:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 327AC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GeWQn8+z
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed3f563739so9815ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 08:45:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897101; cv=none;
        d=google.com; s=arc-20260327;
        b=QFcrUD4coCOO+NRxnyd0386xji5hXqNFrtGYC4ctayIyz2D0tfPBU50GrGP724brLx
         qjPimeZPQv4/LEaB5Pgd868gZJS6lCC/C+9bYULQdvbZQVpSfmJrBYbgP0ESNCoFhiR8
         G2jb7h3f6ELrU1KjJwf6P6XYxdEKuQXn456xw2ooy4SGkJGmFcHnWjtQkt1TsL2Rfp74
         mrR7qxSyHmc8XsxJDt+g4tT211tw4OfIJ4irrz2qQYrP3ESO6JRwXLufJ2n6RA2c9wX4
         SMuUqEjuFoVj/WZsE5KnqGlXet+2WEhfGk62n6QIzj1MGuerOhGWDHnlGijXGPwfOoM6
         sCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wdYtPMhw6iQb9Bu4pea/weFH8wbGNUV9dgjmliA9Fu4=;
        fh=sHzFAGqgTonbSn5ouMu78jAY1bhPDdcldLH/IUJm5ss=;
        b=bRsXZuCMrIn6Bb+AltRx0W+fLXOiprSSmnSu2fap/axZwoHpHcd/XPwnrn6HO75qZ1
         artnIX8Jz3FRTfwgt405SHhN7IYkDAI/FE94erP1FEH1CcmidzKJ7Mo3Hpb6udE7KilE
         0pkPLqDmRVIA/toHHHW+tPSRsBNioDVe62BsoPJvuHXLa39YNlBtVtD4v1d6Ll7IgqN9
         8aIjSThnexkoil6sHR9xBAf2I9sPcKHoTRrXeR42VLwdPnidgxxA3aOmB0j3SCyBUOIj
         D4MKN6zFKbPvzi3A0j07mdtCcG1tLDfv3MAdTVK/Hr2kL5MCOh0hxgaSHUQD3p9ueDEp
         hntA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793897101; x=1794501901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wdYtPMhw6iQb9Bu4pea/weFH8wbGNUV9dgjmliA9Fu4=;
        b=GeWQn8+zTCHvUtarI8ppl7DxE2DxVhnh3Q3uJMcuo811/kyKqNIvbJWgM44d/Z1jcF
         uxmZ4HtlFK3aSnR0TpKMlENeCTJ66Vj86SOJ0/Fdfh8t1Cj7stI7bnd17Zvp3zgU+34M
         bzAZN7oAmeii/J8KUcDC/yM25/Sbdl7PX+ToYXi5fBWmc3IFwetmuW3nrnkHhPSIrke7
         JMadU+uRc/vwrPc410zSBHmfVbJPQ8+Y7/0vOIJcm6g+X7vLsHIE7B3bIW/RS538Hi3A
         MbXbLOH0GrIrlZHra2msMNU/Bx1iAwPKcy2ZsFUi7kZl5+78lIcdmYBOerALR38eOCI8
         4SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897101; x=1794501901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wdYtPMhw6iQb9Bu4pea/weFH8wbGNUV9dgjmliA9Fu4=;
        b=EQ200oamWT5ujG8aazPaHFKpimcTjDqWltFWViGgRqTJlWcndZ2styKLLWFHjqSpDQ
         BzzXbY/yxmVNbpI40J9LSTTnO+rhZe3AuEm2ZL2O1m4uFlIHlrgEjAEVX1AFm0ybYkuE
         Npzj3x/woDdC2vQGEbHQ7Dg2bzqvgDwSC5zEuRccplKuR/3beu6LIjhbZ0dYjCyDI1zY
         g11Kv6HtLgKyDl+nsN4MXG2EC9QdGY1oiAI8o4f4Bjzf0c3KYEEefyPr185ZlQDRXEJ+
         rIlkHjVIVFTMq9NKTxoitr35uTiON4VXGNHNL0oEcnmQSKjIXpDo8JDC4xg8kyRcvNlA
         C/Eg==
X-Gm-Message-State: APuU4Z+B6K8y8avYivu6L/AjhwOnd/zLz+PMg+yoE0rQyS1pW+80jzr+
	gTy2nsFQR/6QYWu7hpWmbeCo3TzP4TRwWa1fJA4abWjezMH//Oc4lNwAiH7b5qXIRVjF/Gnqg6X
	xMPvZ0iAzTLabAzND8DkaQgTrJUSKNRfXrygwN+B6
X-Gm-Gg: AYBFou1rz/VVuAl3B2Y5BOK47y8u+qZxGQ5xgBqoW/uid6li8GrE8ETEwV4Cd1ya5i5
	G8K33tOX7+Ojb84evD+EzGH67f5KtFEfym7J0BFbr0OIRXb9t+1yZrwGJnYd5qX8jTXXxXrkBwV
	yALhD3xxZjpJFIJYiHF+MpV4YPaZ+nD6dpQf4NVc9vvao7PuUYFV4JKPbMMQMy2rEort3GIibJZ
	8eF/pHmoI+vepUZ5beVje6pfZwijZcaew0LkSemlP6c/1X3TjEz7+ewHu5bLv9HFd2JBFkeQeoa
	SXri1aW8yWdpZ77XhSWsuOZEG7v7BLBpRqQqDk9WtumMI3QgkbuUyfZean2pMfvr/ni6VGnYOl1
	uOmWu3JZ0JYz3i33ydSGqTnT54aKW4UKfNnpYtJIqMNQbaMcXrTV/5i8UUlylouezqFA66YQCac
	E7zSPJq35nOriIjAkk5runfZs=
X-Received: by 2002:a17:903:26c5:b0:2e6:344:7bb4 with SMTP id
 d9443c01a7336-2ed27dfcd4cmr5295155ad.11.1793897100818; Thu, 05 Nov 2026
 08:45:00 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-19-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-19-59422ed3e465@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 5 Nov 2026 17:44:23 +0100
X-Gm-Features: AclHuK-fnefOFLp1bzMgat_Ywl30iLttA2NtTvDkjZ9zj3bJEHqA_bwaqAGV1Yw
Message-ID: <CAG48ez2XEE+U4iyhxB6b2Zm88Mj6a36iQX1=X6NyJtB4o6hJ6Q@mail.gmail.com>
Subject: Re: [PATCH RFC 19/38] proc: resume readdir after the last name it returned
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:26=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> proc_readdir_de() counts the entries of a directory and resumes a
> listing at the number getdents64() stopped at. The entries are sorted
> by name, so one that is added or removed in between shifts everything
> behind it by one. Listing /proc/net/dev_snmp6 with a buffer that holds
> ".", ".." and "lo" and adding a device whose name sorts before "lo"
> makes the next call return "lo" a second time. Removing one that sorted
> before the position makes the next call skip an entry instead.
>
> Since commit 895b4c0c79b0 ("fs/proc: fix uaf in proc_readdir_de()") an
> entry that is removed while it is being emitted also ends the listing
> right there. pde_subdir_next() finds nothing after an erased entry, so
> proc_readdir_de() reports the end of the directory and the next call
> resumes by number, skipping another entry. For /proc itself
> proc_root_readdir() takes that as the end of the static entries and
> moves on to the pids, so the rest of the static entries is missing.
> And if the position is behind the last entry when a call starts
> proc_readdir_de() returns 0, so /proc then lists no pids at all.
>
> So remember the name of the last entry a call emitted in the file and
> resume at the first entry after it, like kernfs resumes after the node
> it stopped at. An entry that was removed while it was emitted is
> continued after by its name as well. If the position was moved by a
> seek in between the listing counts from the start like before.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 895b4c0c79b0 ("fs/proc: fix uaf in proc_readdir_de()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

> +static void proc_dir_cursor_set(struct file *file, struct proc_dir_entry=
 *de,
> +                               loff_t pos)
> +{
> +       struct proc_dir_cursor *cursor =3D file->private_data;
> +
> +       if (!cursor) {
> +               cursor =3D kmalloc(sizeof(*cursor), GFP_KERNEL);
> +               if (!cursor)
> +                       return;

(For both this and the proc_sys version, you could instead do the
cursor allocation at the start of readdir() so that you can return a
proper error if it fails, but I guess it doesn't really matter and
that would complicate the code a bit more...)


> +               file->private_data =3D cursor;
> +       }
> +       cursor->pos =3D pos;
> +       cursor->len =3D de->namelen;
> +       memcpy(cursor->name, de->name, de->namelen);
> +}
