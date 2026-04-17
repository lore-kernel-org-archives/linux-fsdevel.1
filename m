Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38EB2010EE
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776424214; cv=pass; b=dja47JoAdEIY8VCj/a638p1mH3fxEHEpXoXsPHySWw+8T6tfk6oiSQRbmtr6Iwy0xocKoJYyQ3o38P837cSdlaBpGIsnAjHke/+3ocYo4vhFeYsH+jaA66fVD95C+1y/u8gkvGGoD+WyctC5em9wcycySo9wXiqH3F98Dy+6lSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776424214; c=relaxed/simple;
	bh=EeXQgnvvda0tkWKSkI75I9gTioHfBlxd9+vZgPv6h0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jv2A5FLFJyrZ6wrj+ukxIjMERdXHQSLUe40YORrWYn1tMeQ4Hjx3IPmO5esEdzON2CSsvU0zlSzjj4Pc2b6cNfAfMzarQENrAXk3GnnpLRkSnUzDjPef0btt2RWD1MvMdeFl+9R7rsabDC2DAId26Sb8vuIa2dM9ynDE4DbRBPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3MgOI/Y; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3MgOI/Y"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba36357195bso59270266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 04:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776424211; cv=none;
        d=google.com; s=arc-20240605;
        b=RycIFkMVcMOJeyveem90M/6pEGCoSEywx3NRt/FKqriCxOt0jQGGNQ1iR64ruhYBTL
         7CkzgWcVVwtNtm7nrJD5G4BcI9vVIT+j/6WDljGappp8OUS4q42sx4ObtAioC45zSQKB
         bO9YSxCOqnUVxEAziV9yf7iQwPiO17hxQwDU7+rFsQD7tQz2hN3xLFQlNeBQcEioJOQg
         OAZaXkuoAKFuvvqqImGAnl7KD3YHhF0nXvhGfZhRK73M4PvseenQrPTxuBvomgcr4+tr
         KDzAu8CjzafBThxx1MfXya9Nmb1nZgsKDYZ67oGm9/W2wC3/XglzUspi+GWCti506osk
         Zg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5OH9D3TrC3YT6xcXIudyStnqBJ7s7Q1wwyKT59oD0g=;
        fh=KlWX1lsY+dO0s7Vf9+SnR9Jh0gTYNKnO31dmlHyUTSk=;
        b=EnkkjjuLaTZocoy3yYFrtNRXatetjInxH27YarKssbz6s62thJeP+Yt9WOV78QeCfk
         8SGE6pXv9212iwo6ReSCnXHly8nUqpp8iuzyZ615G/TyXqS+QhfpRk7Ow3idAGB9wUV5
         daMSlS3Dcg/YcqmExbUr3IqhrC8x4ihlSwZFl/dfAn0F9BTwXEHnfKXXO8zMAzmaHBdx
         1LW/9BPIGiAfRdKr5POmIBpKkgHg2yMnwvqaLg3hkFSei3I9k3ASuRPI6EitQFuqBFAq
         TcVJQboyDTSnE3BnCTtsKe7AsB3Su972tGfugQ9Xs6LSaRo80CJ+mi36fQHKJQlRP71P
         4goA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776424211; x=1777029011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5OH9D3TrC3YT6xcXIudyStnqBJ7s7Q1wwyKT59oD0g=;
        b=L3MgOI/Ymjqpv2cywWUdt80OvLzGN5pxJNLMdGXNNx1bJpGEfTZMuvb62KsamRSRiR
         x8iUDSi96zOw9bbSwUp5WsGE8nNLi/y5RKbqPqIUGChJAu2cAGhsqgzEkeODNmDibxKM
         MEZo94g8EcX9tvZ+e+SZFZ1SnNG7pq5/LI41FOMgBbIedBSt9CM4tYo5MXCV7ccSrASP
         OhrfycveRTKj7ShDVpn7YgSHDHus51FKgjpUoi6td3Y5NLVD7XA9S36sdB670NFZp+oX
         gfZDlHsOe7eOd0SMve1ZpPmT3BWDWmbUHXyx4IRwjyNo7zvXQNnOtUFDlqOE17SHNp7r
         qVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776424211; x=1777029011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5OH9D3TrC3YT6xcXIudyStnqBJ7s7Q1wwyKT59oD0g=;
        b=dYcAqguACK3v2oHfzME6v7LKiN8QWdS1SIiJeJK+9bNkvSSwORYSv37d8utIELPLlb
         Cs4iiyUW+ZgDq6nczIUwNWJ5Q3RX6LOiQ7ydqEPTM/Dh8Jc1Y04jGWZKOsxbJwhkqT4K
         aW4wYsUWY0qtoLRKN9xPt0vawqyucqtvOz7HO7IDAkYgNERz9ANAuuYmABot87Va0E+D
         CmBn04nTk0kZHfzdZaER5HJGDGyXgc9crXwtmCfEPV6G8XBzsPjk6mqyeRlEqyclRqsa
         LH8Nk3dUlDotumsfpZ5Ef8bL/ulaDYcs1lrviCD+TkdipIJLC982dbr+XFTFEDun5na4
         Dlog==
X-Forwarded-Encrypted: i=1; AFNElJ+hec4aBOhsNfU9ElmLqsfLKcNkPHlMZFfi3Mp/CzP9vOqtXlaXbG6+XHqGuYT7oJk9naD+7zytDsglq2KE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy718EdTee7WD2DViJdDxDwWj/drZd0ZnAm3RyLpTP6X2J30Nd+
	pAD5Hafo4kaSL2xZQJf4QEXm8OgC0O1NDJCgcvUkJoCrCw/SBOmVqkqAplVEwQGhtuTQZZDJ+Of
	VI2WIosWhxtp6esweR8KZ/7aYMdLHUrRNRcQj7kYI3Q==
X-Gm-Gg: AeBDietEnzeuwl9rbmm7xCiLVwwqJJTr+a+AyDrzllu7B+fp16qE24rfkIl8GzWkYDT
	hFhdPkcwYkrN827wzqcjv3BLfKDrAk4+62KSk90BaUQyIntpnp4kMXk9sC7Ea4EpdaaKdMjehk1
	xJJpBMIdebVzK7MZGgB48GdwofHYMfLaoodSmWhXEscACYMAMypfSc4Ml+nc7ltx8+kZIT0nDnY
	cMxaiP161ZNggmF0T2muL2Sy2D8MQfbWY25RgW4lNuWJ03kov1+o6cNumfBF5fp0bs2l3xEh4rP
	2JGTI3Bwwc3/JB+10aL+kKu6OeeXsPUCUp/7uKbKJBy9jauLBxYW
X-Received: by 2002:a17:907:3cd2:b0:b9d:30b1:66f4 with SMTP id
 a640c23a62f3a-ba41a24fffdmr126323566b.26.1776424210702; Fri, 17 Apr 2026
 04:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com> <20260416194844.3874004-2-ibrahimjirdeh@meta.com>
In-Reply-To: <20260416194844.3874004-2-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Apr 2026 13:09:59 +0200
X-Gm-Features: AQROBzCByyRSOoq_NpQDLrkyXJSnyKIhXwWfIkl4cg1eFQiahB6QKysY4kSEb-w
Message-ID: <CAOQ4uxg=z5im3rOw6JXrNY6-ynBEoj_tF=Fsiu81xqiCBRfOjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fanotify: add restart infrastructure for pending
 permission events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 9:49=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> Add fanotify_restart_pending_events() helper that walks the
> access_list and reinserts each pending permission event back into
> the notification queue for reprocessing. Events are reinserted at
> the head of the notification queue without merge or overflow handling.
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/linux-fsdevel/sx5g7pmkchjqucfbzi77xh7wx4wua=
5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn/
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index d0b9b984002f..787e57a00466 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1095,6 +1095,36 @@ static ssize_t fanotify_write(struct file *file, c=
onst char __user *buf, size_t
>         return count;
>  }
>
> +/*
> + * Reinsert pending permission events at the head of the notification
> + * queue for reprocessing. No merge or overflow handling.
> + */
> +static void fanotify_restart_pending_events(struct fsnotify_group *group=
)
> +{
> +       spin_lock(&group->notification_lock);
> +       while (!list_empty(&group->fanotify_data.access_list)) {
> +               struct fanotify_perm_event *event;
> +
> +               event =3D list_first_entry(&group->fanotify_data.access_l=
ist,
> +                                        struct fanotify_perm_event,
> +                                        fae.fse.list);
> +               list_del_init(&event->fae.fse.list);
> +
> +               if (group->shutdown) {
> +                       /* Group is being shut down. Reply ALLOW for the =
event. */
> +                       finish_permission_event(group, event, FAN_ALLOW, =
NULL);
> +                       spin_lock(&group->notification_lock);

This looks very awkward.

We are holding the notification lock for the non-shutdown case
throughout moving the events back into the notification_list
(could possibly do that with list_move() if we keep a count
of in-progress events).

Seems more reasonable to also finish all events in a single batch
if the group is shutdown and then maybe use the same helper in
fanotify_release().

But Ibrahim, please wait for Jan's input on this before sending v4.

There are many ways to do this, and reusing the existing
finish_permission_event() locking semantics in this loop may be
fine for simplicity.

It is also a matter of taste, so please wait for Jan to chime in.

Thanks,
Amir.
