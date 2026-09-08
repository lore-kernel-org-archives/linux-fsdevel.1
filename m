Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14F3A961B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854890; cv=pass; b=ZtLfZowPSa8kXpgX8AVbwjZSvUQ+av+zg/5s5TpqZBYz9Eo6LpSDc+1mG7qZEPT6MZ3ySR+WXymh4Or/qCtbzrAdLtfBJTF16jD49C1C4v3Jl4lG2HYcBJH7Q8SAEy4tBuSNWV1rgwZ7XvpIh+R8s5/jsvwTu3ErnCQgDSNjS+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854890; c=relaxed/simple;
	bh=tXGbdgcqzz4CAJeru5w2V89eLrYgFnhR0h4hmZG/qUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRgdF31uBhabJbHorUiTO+ttIkDHc/sm6yyCvg6UGZAUoClaFbS8F7KNLDnZHlzkD63/W5/QOQR8yhcDXSrfxOqsJn9YdtH+Rp6oawWAxLmEAXlrce7pk6vumjXC6JHRJQULPGXeuiT2udI+O+sANsmqCeOKhOJR+hf8aHtw5Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ludBNOlo; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ludBNOlo"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so410066266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 01:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788854887; cv=none;
        d=google.com; s=arc-20260327;
        b=PHxcFMMq+XEujeK4283R8Qj/ez+DMwSNtMaEqNDiAsefLXEYcpP8VotyYhhx+QQYwP
         HR6pY5DMCHDbfLpo3HH/67guLTGD//ntpCqVzY7o+ebJ2YNgBNI57OvKlaoZ1bvCli8I
         L0uDj3wBY/qALoWQdVyBs/EMcGXV2qPOg7WgESz+qFq2ShMF2/zbS2axXSqeQV3uyBKE
         LfYZaq/Z2jatDMexii3dnSYrkaA0MkyHdc4/I87hfo5rowzrW9Oc9BM73Dk8Fw5y1Z9a
         +jzBT8P0eQTJSDBuOh/hYDUVlBYw3+IR9EI1r5YagXVZ9ZPHtIqUwQfj9PFbiEXZWa3c
         SlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sa6upqADQlqR/MmaNL6A6E6rZ+XVW/lKGKReqxKXRig=;
        fh=IfLwjWy+TJiXeeVwpYFGYk/H+zLkjkXs828uhCVLV5g=;
        b=XND/LJimoBmb8Lip5aIuSBAnfAukKvsNjKvehiOEGa0TDxkaFY4jYfvEiAWj/YrKuC
         x90K1QtQSZHrRRzk2a/aDJa/aLC62dWq3mkQRdUpRonAVrF60HraRDermisQbcWoIOLe
         YLSyE4bipiI6Yma9D6XFM7f4T134zDK6l40KG1Qz78hfnf9+JdL8UXto/hucq3q1Jllb
         /lEXzF2arnhszfstbmtmY2JjDLsdphJ+qziWqGLhPkUD2HTWMQzPamkDIgfdUXDJHaBU
         FRk+zjCpRHOkQN8FvtaduIbqXJil5d/HcD0lNYAbIpWSow9MUkHIFTak6bNBPm7oHOcX
         UEfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788854887; x=1789459687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sa6upqADQlqR/MmaNL6A6E6rZ+XVW/lKGKReqxKXRig=;
        b=ludBNOloWCYsKmGBwbyjEB7iHpzPOQ3dJGazMLGksLvgB9tqpSjkhZZxa985so1aH2
         3pJ3E9pb+nDj7A45X1dK6twrpqjolQedV5+W2jH7IoQ4KLzQ0rbLmzPr9+uI6A1PNEtX
         2wgEyZyI7usjpevhUo0cA4xM5Gmq+onUCT+74Xk8jAh2emolxJtBeaKcq/x35AuJWGnN
         kDddntYipUOWh5Ovm/s0zRY8XKgWlUgAQVKd2iL++fYQDzJICt/CIWxZjj9T5Vx8EERN
         IRW2R7mbL1ehStJfxSr0MTvtL1hoDMwWyezFCc5QL/0XwDy3Eu6QQTCV4A/Ri5V3yx10
         K+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788854887; x=1789459687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sa6upqADQlqR/MmaNL6A6E6rZ+XVW/lKGKReqxKXRig=;
        b=EKDAfQdtYlx/zh83CZOG8OsGyt9EXnp/t4AufVmyGc5SKW2W3spHNgSaVaYbyq88Ug
         fhpaYLx5e3ICNOHdLNtCN2ILYmJgOW20/JKRugnsylHT8RmivamSPomkgeLwHpNbxBH0
         pVtpIBA7nPiZeExEOPsAt8JxfZU1ZBZnt4QfeOjx1R6LlxlIplGt85RhPffyR6pPi55C
         9xkTCbR+rr2BmkoVrjE0CBM5XMZDPi9pD3Ckt3lx4/Bwv65AxEzolWm+HoHRgynSUHVh
         vE3zYMIJXUOjqugOTEtKd068/99vRpxR2FVBv64JFfMZKZZpxJlwVDf6OUwq2wgWmhcM
         JLGg==
X-Gm-Message-State: AFuF++myvw8cO4Fj8k0didveecbtqociwAg2w7+3jWNUsP9gMnO2cJLO
	4PR+jRZlMFaXipBVWWKYANgpHNlCbdUyfmAAETLp7x2J+aa7SkPYqfNgnL7D6Xi28g83jYactBW
	C58ydixmIuuxwqtBx2TGd5joGyr/GrWk=
X-Gm-Gg: AYBFou0oW2r6vPIcfDBsOgJeToBUOtlf2EffXkiTm0l0CA1fIDRJbJHMfDzY6I/fb//
	+ICEOnubbAZT9IqkQkDeCsL0nic6fXYg19523vM8zaJXXvjB+zozgvWEgBQGF+PajQeRN1/1kxf
	BtJR2qjfVPeWi+XG0NQyYyB72mN8UpDQ+aJDLVh3LiJZYDtzfhVbiRPWckKKqR2dhz6dy/Z6Vc+
	1BwGJQiirNnsny67TRFqsEsK8qU9fUOjMrBUb0S/lwEkGY0pwEeztIubpgfSUpmREebjsiHAsyk
	gKeWq368QdCN84zcxtH5UKW30JUllaV+qwQDfR/ghhl/huRmSq6ukF1aOerI+mgaTw6l57AL5Aj
	Jw6H0PuzDew==
X-Received: by 2002:a17:906:8d89:b0:c24:c250:a6b5 with SMTP id
 a640c23a62f3a-c260c993a9amr1051714266b.12.1788854886462; Tue, 08 Sep 2026
 01:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9fbb6bf2-70ae-4d49-9221-751d28dcfd1a@redhat.com>
 <o6cnjqy4ivjqaj4n5xphstfnk5jznufaygwmfkm2gyixqgfump@7fc6c6h6d5if> <28f144f8-431d-4c3a-a362-56083bb77541@redhat.com>
In-Reply-To: <28f144f8-431d-4c3a-a362-56083bb77541@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 8 Sep 2026 10:07:53 +0200
X-Gm-Features: AcwNN1V1vd5mVM1XveYVMiH3ACcL2s2pHzLcWY3GJUvl9XLSZ31SO_QV5_aeSjk
Message-ID: <CAGudoHFJne0q+dnjYdXOyDKEfu_zZ71_z+kSiUPiHWG7jCBw-Q@mail.gmail.com>
Subject: Re: [PATCH RFC] fs: cache-align lock_class_keys in struct file_system_type
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, lkp@intel.com, 
	oe-lkp@lists.linux.dev, Alexander Viro <aviro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While I'm not convinced spending time on the resulting bug is
worthwhile, with the arrival of sashiko I think you should rebase &
resend -- it very well might just point out the problem with 0 human
effort.

On Tue, Dec 30, 2025 at 11:45=E2=80=AFPM Eric Sandeen <sandeen@redhat.com> =
wrote:
>
> On 12/30/25 4:04 PM, Mateusz Guzik wrote:
> > On Tue, Dec 30, 2025 at 03:07:10PM -0600, Eric Sandeen wrote:
> >> LKP reported that one of their tests was failing to even boot with my
> >> "old mount API code" removal patch. The test was booting an i386 kerne=
l
> >> under QEMU, with lockdep enabled. Rather than a functional failure, it
> >> seemed to have been slowed to a crawl and eventually timed out.
> >>
> >> I narrowed the problem down to the removal of the ->mount op from
> >> file_system_type, which changed structure alignment and seems to have
> >> caused cacheline issues with this structure. Annotating the alignment
> >> fixes the problem for me.
> >>
> >> Reported-by: kernel test robot <oliver.sang@intel.com>
> >> Closes: https://lore.kernel.org/oe-lkp/202512230315.1717476b-lkp@intel=
.com
> >> Fixes: 51a146e05 ("fs: Remove internal old mount API code")
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> ---
> >>
> >> RFC because I honestly don't understand why this should be so critical=
,
> >> especially the structure was not explicitly (or even very well) aligne=
d
> >> before. I would welcome insights from folks who are smarter than me!
> >>
> >> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >> index 9949d253e5aa..b3d8cad15de1 100644
> >> --- a/include/linux/fs.h
> >> +++ b/include/linux/fs.h
> >> @@ -2279,7 +2279,7 @@ struct file_system_type {
> >>      struct file_system_type * next;
> >>      struct hlist_head fs_supers;
> >>
> >> -    struct lock_class_key s_lock_key;
> >> +    struct lock_class_key s_lock_key ____cacheline_aligned;
> >>      struct lock_class_key s_umount_key;
> >>      struct lock_class_key s_vfs_rename_key;
> >>      struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
> >>
> >
> > There is no way is about cacheline bouncing. According to the linked
> > thread the test vm has only 2 vcpus:
> >> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m =
4G
> >
> > Even if the vcpu count was in hundreds and the ping pong was a problem =
it
> > still would not have prevented bootup.
>
> Fair enough, it really didn't make sense to me.
>
> > Instead something depends on the old layout for correctness.
>
> If I add ->mount back to the /end/ of the structure, it boots fine again,
> so I guess nothing is expecting specific offsets within the structure
> at least.
>
> (If I turn off lockdep in the kernel config, it boots fine again too,
> FWIW.)
>
> > By any chance is this type-punned somewhere?
>
> I don't think so...
>
> > While I can't be bothered to investigate, I *suspect* the way to catch
> > this would patch out all of the lock_class_key vars & uses and boot wit=
h
> > KMSAN (or was it KASAN?). Or whatever mechanism which can tell the
> > access is oob.
>
> Can't do KASAN or KMSAN on i386, AFAIK. :(
>
> I suppose I could try such things on x86_64 just in case something shows
> up...
>
> Thanks!
>
> -Eric
>
