Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17224887E
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519927; cv=pass; b=FC4a6HcxBLJY1u+2s8WZa1TM5ElPsUs9H1VFZi4GTta7VtmcJWDxI4xjgfCugm7oS2/mYxv0UKD6LbHDfWf8huGHehapl7GyKHxsK4mt0FLjaJXEi7moaTIJV86aOiAjtVOoPuRdQllczs5i02KNQfi3EYW1uE+WfCgOvsjGdDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519927; c=relaxed/simple;
	bh=vTAyvt4KJAeMmvi2USwEZousoYluq1FSg5GORmp0De8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7zwIYCr1IhPc/6S/CPh6qKEYWxgX5trZahP3wmhksT90WBc7rSgdpeSsLntiGOL6OTgy2m78bZPBIkziEJ+r5OgyINDqWR1IjLw6YiT3XPIgAZJdww0wpt5gUmaeW3rl47smuy34GcutenlHmPMUkquyGIXyZLwM3JirMfenLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpnCxIPr; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpnCxIPr"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67cac5ece75so7676749a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 10:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778519924; cv=none;
        d=google.com; s=arc-20240605;
        b=A9Uz9VUx76M/74P3DtA74uaUevyig0mJu8R+6sPU8yLSqAzHSkY3hX5aVU7qM89J8u
         ilasL4NSa8RRPyHcwg7+DZCMOlz6bIyHW8eWoMVq5xhJUNf4EiAWGzf60Xhk2FCPHbx9
         gb9GCmu7Ee7O7KvQtYJ5WFJzIbbONjm90wv9ma7CLuTagwJYPH29aLCQAJglDptyJbEG
         RXusgPG3pkLkLQq+IBZiQZYwu3pzSeo+llOe7xQqBTT7aTZjdw+UbSqPU9C/CCV/ZmKk
         YsnqfqAkR9TZC7hUe1JiUQubTCKWfqhNVZzEfrE6oAXg7zyzv+V+1hwdQfD5o3yREuOq
         JN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6e1iOP4o0+fqDTjbfq0VbT57a/DIvrGH5IJQqP3yrx4=;
        fh=jwkGkOXMwBQ8iFkDDQ3ekbpn4PnSDLEEflj7i4bnxc8=;
        b=JoxyyZg9KsfwSg/sv1ksbjuJ7K1kvUsBAJMwsN9D5sbJeyuU3lRS+cx/RagSGLU0uE
         Fomp1WOr2+iQsUX/beCHvSBb6VvfIlWj0+R5nxwQ2NrY/zkYOR4VndBlZG8OYWvm4SfV
         k/c5qCw0JxxSzdYEZPnOYWHtNY/C/2UsLHHqZyWUe2RHDhTP2dpaO8QNz96gDUfy+gbH
         xJ3T84NQQP4YFdkCOLKwO2TIJFF+vGe5PH2qO0v5mMdfYCMepQTM7v+x9C21pfoCNIw5
         wFGhlcB9bWdXg8i5w2zDfljp0IBKmThkfw8wBPwsb+QdKJLq4cRMb5+WefjsyZqkA9iY
         D5ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519924; x=1779124724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e1iOP4o0+fqDTjbfq0VbT57a/DIvrGH5IJQqP3yrx4=;
        b=RpnCxIPrmzFoTygCRDwPoCewGGi+qAL4Nzh4E1kVKFa4xHo7dOfW3jMh9dz/mGJwle
         tNog0qZBkR/CW71DzSxz201TJbGTKPwPC7UxXn/hf6e4GUU6fn8kfiWC/9LoJtuDAUS+
         ac1QKf+2jOofo784GJJcBINtjZ50WBg00RcJRzlLmiz/t6YFkH4BNYJ8hVSkTAoRmA9W
         Adxhb1klF0S8aTqpacgrHHlRtJmo5UxJeyxDrJGpANqnzK+gaZ7hdBmaeM1TXoG5W9rw
         s05YrAf7RoGAHK2CD4MiwY30uDUZWmxZu0KQFi1B+2Ge3at+wid1oWMzpzrW+TzbfcUV
         oyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519924; x=1779124724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6e1iOP4o0+fqDTjbfq0VbT57a/DIvrGH5IJQqP3yrx4=;
        b=pCMSkB2AO/hwzb+TZUM8Xt+h99eqfNze1a58U3rWEa/E18m9uuONXQNYGWEl9lDe05
         QX4qRQcDMzHs6OfJ19H9qwo9mVr29tNbeK9o47m5iOrJa4HgmyHlqwrlRg2hbdDJu9YA
         EBqO7lYj1V3PAjp/Wx06TDwnplXYzjUolE6GzYnkAuyQMcwApjoXvvdoCD7ZXecBQ23X
         MAzuJgerKph8nBh93kzus832NvIjBJF91Dk6zA5MpVChHYUN9Lygh+2e208YWQb9tFvY
         k8z6ZnaJ1bKLm9N2Vr0bMlTHY5Z6Fr8e5jQXTah5bCs/DJXsv5Z5PRGUXNTqn/8WGK3b
         dyFg==
X-Forwarded-Encrypted: i=1; AFNElJ/hdsBPccesYvIxi6T2X1+UvszI9OwWsPFcBdaFCvPatcu8zH9y264odJMwng+A3Lbtwu0anEZtc+JfXUHy@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqnBLJs5J+Px0TBai7zKSO51XX5rejTG5vNi/Dr0VoFmkFJJK
	d1OoMoOXNhv4xHpr0ac5qFObmRGcibONMSDgQQcaGZR7JDfDCq0Dsf643KShMvsku7AxxZiewld
	gazP9rp+fBxATTCGjHwy8npLchC2BKTA=
X-Gm-Gg: Acq92OFpdUVHGRJSkfS3ZnLkwzUxtwHMDMDow+MLcKKqjUnnfNzvYvzBLcqG1IjwR4D
	2osPb0FYUd0DTaW+S6dtkXEHVvGIqzFUK4IpSUr1PKCCa3am8JeiIVPQpu1+zFiKaSLRDLg0wSk
	rDJmYYNbcXVHiSQYPL/1Z1BXHVzTGdNlsXeyMjgpQcdorKoF4nr+MN90Mb9Kp9qbQ7gtCLokwNv
	FSQ4BuVMxNI+LtHgNPIs2wghAe97T3LJEPGdjxzQorJwQTbtdOeLECsO89sniRHMIQej40reeNF
	WttJcUTPgCeDoxJRDxQCpfHZwnkcnQrt7o1BS1NsxrPzB9NOqPPB6JGkZ2jXIg==
X-Received: by 2002:a05:6402:3509:b0:674:37b7:227c with SMTP id
 4fb4d7f45d1cf-67d63aa055amr13016647a12.2.1778519923727; Mon, 11 May 2026
 10:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
In-Reply-To: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 May 2026 19:18:32 +0200
X-Gm-Features: AVHnY4J2LowBbggJwZFIYxcstb6YO_MVN_SJAWnvOEiWS4HFZUfxz_BmmdOmD0k
Message-ID: <CAOQ4uxhnOEkX4qnn0wHMCqWhEeAGTR9rxcw5u_oqGUovuszo0w@mail.gmail.com>
Subject: Re: [post LSFMM summary] where is fuse going?
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel <fuse-devel@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	John Groves <John@groves.net>, Joanne Koong <joannelkoong@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 5:12=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> Please let know what I missed.
>
> CO-MAINTAINER:  Position still open, though we formalized some
> subsystem maintainership roles, sent MAINTAINERS patch.
>
> FAMFS: Let's try to find some common ground between the fuse-iomap api
> and the famfs api.  I.e. add striping as a generic mapping method,
> even though normal filesystems don't (currently) use it.  Using BPF is
> a bad idea.

IMO, FAMFS sits somewhere between PASSTHROUGH and IOMAP.
The simple nature of the maps, the fact that famfs maps are const and
queried at file open time makes me think that famfs is much closer to
PASSTHROUGH than it is to IOMAP (in its full capacity).

I think Joanne has mentioned that her customers have a use case for
multi backing ids per passthrough file and I assume this would be a pretty
simple map, so that sounds pretty darn close to famfs already.

>
> FUSE-IOMAP: Need to reduce the scope of the patchset further, as no
> one can sanely review it.  Idea: first just implement static maps
> (i.e. read-or-re-write-only).  This should be much simpler, yet could
> demonstrate a read-only mount of ext4, right?

One more perspective regarding FUSE-IOMAP which you mentioned in LSFMM:

wc -l fs/fuse/* on current master: 20875
wc -l fs/fuse/* on fuse-iomap-fileio: 25325

We have just taken a tiny bit of load off you by sub-maintaining
2200 LOC which you are less familiar with:

$ wc -l fs/fuse/backing.c fs/fuse/dev_uring.c fs/fuse/dev_uring_i.h
fs/fuse/iomode.c fs/fuse/passthrough.c
  179 fs/fuse/backing.c
 1371 fs/fuse/dev_uring.c
  211 fs/fuse/dev_uring_i.h
  275 fs/fuse/iomode.c
  197 fs/fuse/passthrough.c
 2233 total

Merging large new features without a sub-maintainer
is likely going to hurt your ability to keep your head above water.

I realize that it may be hard for people to commit and that the atmosphere
in workplaces is of great uncertainty, but this is something for you
to consider.

If we are being honest, then we need to develop features that users need
and if users need features, there are usually employers willing to pay for =
the
feature development and maintenance, if we let employers know that this is
what it takes to get their users what they need.

Thanks,
Amir.
