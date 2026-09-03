Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175274B1B2D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443491; cv=pass; b=XW994MKzFp0jHTyME6EGW1N06yMUygq9e9EicWGb3u1KaL5MQX+me8r2BdV1kyuqL+Uuowmv3JyezSXtSjNNaZqsvMAXdSls2oXvPgR135gK99Z9LyBv7tWWyKeUkdUz0qrQQaUbuyVrYOlP/wJ9Gk8xcYZmPgGrJMTNRUf66L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443491; c=relaxed/simple;
	bh=CnepmmzELbEjghYI6j0ZociAv62uiRsm0df/ajYLGG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW0iMSavrG7hYY1foBQb3l4CfsDBhJF9IvxpZsuN3GwIw2O5FhhQc4WtOWFaZwnk5nnxUv7NhD75LswIhREHP2FXUoTpyJtYzdhsgCuUcQlvYBWYLHYG8khQ0JsT7fpWJZskcNJLemvFvxinzt0a1715Qye7dpLqiu7wi7RsKHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihCbHIw4; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihCbHIw4"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a68ab90eb8so983089a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 06:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788443481; cv=none;
        d=google.com; s=arc-20260327;
        b=b+sq5k18JOYW63IwsnPqdY3L34WpQDXkMHAyicu6y9YsbRfcZU0pkrFDRwEBNqXEbk
         /fy3gFSmdxUT4vXddYhVXcP+VunR5ZO7ILJ4b8vcNQCSb6AfLysVrkm/2IPy6DPVzw6R
         kG+Jc4xAkN5WYvrLgFGaqK4ot1+TG5V5SAj4ykVA0tjPlKq/7ItgZy40SS1hXiHr2j7U
         1MDJQWwumxYka4n2hgmUQaZk62W/i/MLvgllL7JStLmbnW9hzNRuMzfnxGgt6FKomhio
         EHM19Tk0H+lkDvKwxjaQPRkFTlmIbaesRahuCSk/G1ELAJUHiRq5bj04jFOazux/a4X2
         6dQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MoZRNEtYIWDS0IurH9QV+UfQGtgGdZsOItW/ktopJYY=;
        fh=UyoGpGU2lalMm+k7NyO5sVfVs7dxzVFcOlBYPWtqBFo=;
        b=U2a9M29Ao55QL3y5dJMa/ayTNKZjRzyITU5+YnsTVrPb5y554DM4jKoOJ5skPWZTJN
         7IxqOPkV/+JXjNRrGqxeXQxTHOe4vfJI3UtVNx3v+roEb9ddu6WoIl+H+IOqrto2XcDI
         eq57jynp0F/25RNR+FKiuKWssgr0wbGKKZOpzkRzpO7Sp/COS+cQi4ZAheSrmYopcrcX
         9yti35KiAAlyIJpowiW8nROWB3hxOXkZoGQVv998mpXRLLXAv7y8pyoAqv2/Y3lnA25m
         dpazr+LJlYi+9h0QYzOP5vhLrlya8ats8xTpgDlhTVnk1vrlfxc40ahbw5Jnp5fxfNh9
         v9sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788443481; x=1789048281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MoZRNEtYIWDS0IurH9QV+UfQGtgGdZsOItW/ktopJYY=;
        b=ihCbHIw41Cpllq2Pdrh1AybFP3rOn56Vt67U8mhzTSoyolGHCYUbHv4mgyX8LmDPp9
         GC4gmUyplFlmhdyahxu/XXLRq9TvT2kSymhB2d5I/2p/IRx+Cl8Rh7zhYqb96ArMB/lU
         PdG1cKmWln3Q/5xkUbxma5JpP6W+HwsDBHnHFUu1DUnqSwi4iUbF/5I+O6UOVcFuOKf+
         MFLQDWDtmc7GNngbWlRYEWQEoLrHzfhKG6m6RCH8taLlZ5LlMPJn4Dp5n2DauRFZ0K9N
         KGYuaFgYVfvF+/HYsdNOQS7LNfQqm7OfBudQDfyV7vMdB56z6HaKIWFqFGWwVy9tYJjM
         4h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443481; x=1789048281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MoZRNEtYIWDS0IurH9QV+UfQGtgGdZsOItW/ktopJYY=;
        b=RXa+rXpAxFkGHA1UcIe361PSEXDGXiacKCt5tAr/+Jz6jndiT36CYkVAkNQr9vg7Vx
         aGL+I0Q2jvleGcyvwaRhIUEN0rC17UveI2dSGQhCgP6FN4z4GRBYlCqnL558x29i2hJC
         AvP2a5kdAw9j3ULuk1PAqlNyBGE8S5v6laDQ4BDGzfsBW5NeMof5X2kDvRMzOaK6X4NZ
         4ntQ3+n8/0mYnzqhNICBZ/PHzRAEsZduEAi0nRkxMphSpqyEdsfAbrzxKjtyFLEnbSwQ
         JoNsj5cshJ6Juq87L/18VLnuYlST03zK7ME/ug7Io0mtSG5YHHyq+1cmQ4TrINL/4yKG
         HX3w==
X-Forwarded-Encrypted: i=1; AKwUvBwyBfiF4Yl/st6s7wfo5enk2OYACwN2QCpZP3+7vgL5CqLoSWlU4u8LbF4ZRe6nXDjIJYE+UN2+OgzFN/T8@vger.kernel.org
X-Gm-Message-State: AFuF++kwHuEv0RQggbN4gZ+lQjSihffocMKwBcrL7TS3j2WFeYwor9ba
	n8vgufwZuaCBSNoYWywQYmeZ0Py872kxMZMO7ujHeDpKroOE+EZPed9ziiAe5/lIYNtdna5zReg
	bXVZ4DuNUW8MZ9pxAlBuFxbAUYllq+gPmQPrPa8w=
X-Gm-Gg: AYBFou2qWJ+nOUotHG9Gi0bNLL88NyjLSS52wrnU/F7KhPBXXpHxz8K3ymO/XlXBox2
	XJjJFd6MIcs4ocPd6TA4b6FjD1mfFceli7ddprVNy4QaiIqXKKWc3Ff8xGX0dM4KkBNvKLuqnF6
	eTCXpDaUf9q8fjME16IAYzkA9CB3SmB7nKSsgFGim2IvkpLxeNgnchuAlmpl9R/J63ldJX+gYqw
	gXXrVszgt/+0HoxmciGqAqhXTVs6uRW6uhEvvLQwksQwQVJmTflg+nb2CSj8XQJonN4bElrk0vG
	PC1o7RqWynf5bohDZiUE3fmgbBQ6A+K3KkQh0vuROYXXElz8O/jvvQDh
X-Received: by 2002:a05:6402:4615:b0:6a5:f814:2278 with SMTP id
 4fb4d7f45d1cf-6a7e551f77bmr22171a12.2.1788443481155; Thu, 03 Sep 2026
 06:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903132636.1113789-1-cui.tao@linux.dev>
In-Reply-To: <20260903132636.1113789-1-cui.tao@linux.dev>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Sep 2026 15:51:09 +0200
X-Gm-Features: AcwNN1XLPOGjY6GkGn_VD8RO3WKWNti90NMjrqMlxwQvVF-i2CTvjSe5-uBDR5U
Message-ID: <CAOQ4uxg6_0wnzBmA+-rZeADBTKwLsWFdEM5ZVGa6YvWX6mAGXA@mail.gmail.com>
Subject: Re: [PATCH v2] overlayfs.rst: clarify the scope of file locks taken
 through the overlay
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jlayton@kernel.org, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:26=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:
>
> From: Tao Cui <cuitao@kylinos.cn>
>
> File locks and leases taken on files through the overlay mount are
> only meaningful between tasks that access the files through the same
> overlay mount; they do not conflict with anything that changes the
> underlying filesystems directly.  Add a short note to "Changes to
> underlying filesystems" stating this scope.
>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
> Changes since v1:
> - minimal note within "Changes to underlying filesystems" instead of a
>   separate section, per review (Amir Goldstein)
> ---
>  Documentation/filesystems/overlayfs.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/file=
systems/overlayfs.rst
> index 16c35b491dad..11af5bc73e32 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -671,6 +671,15 @@ filesystem are not allowed.  If the underlying files=
ystem is changed,
>  the behavior of the overlay is undefined, though it will not result in
>  a crash or deadlock.
>
> +Note that file locks and leases taken on files through the overlay
> +mount only provide mutual exclusion between tasks that access the
> +files through the same overlay mount, and a lease taken through the
> +overlay is broken by opens through that overlay.  They do not
> +conflict with locks taken on the same files by anything that changes
> +the underlying filesystems directly, so file locking cannot be relied
> +on for mutual exclusion between overlay users and such direct
> +changes.
> +
>  Offline changes, when the overlay is not mounted, are allowed to the
>  upper tree.  Offline changes to the lower tree are only allowed if the
>  "metacopy", "index", "xino" and "redirect_dir" features
> --
> 2.43.0
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I'd like to wait for Miklos to comment before merging this.

Thanks,
Amir.
