Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65B5625E7
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093502; cv=pass; b=PQnJEOuqnVv/xhArMBvBXxVc6b3cNv3Oo+QJ97YjeVwoKHzDiSy8rXixoH7de3heNOCa3yi/FwFUB7+06VItR3PFnnUUWTBI/zLW4bWrwB6acMSwCC6vZbqxZI0QpFg6uSR9PE5YcqmWYP0DnwVs7IB7ovaWgtBAikCCyWmqurc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093502; c=relaxed/simple;
	bh=f2zbqc3dDRzii2k3yujXvHM/HIiUUDPd57empLhzWkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3i/dNY+opKmDRSKtl1ZoBNFnz6h9j4/ggYJVnkWAMP7AjNrTXFnsTCHGrXoGN89WD9sIyOYujtRjUVS/HY6amxdGLHasVXKnP2HLRJHIQLNom0frz+/tu9Xy+HCheZkcO/9puFislBubiOjtQc0OoDmFHMSnNgFLUMwxFxyZ6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (1024-bit key) header.d=omnibond.com header.i=@omnibond.com header.b=bhopPWi6; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=omnibond.com header.i=@omnibond.com header.b="bhopPWi6"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f204f6so58887b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 09:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790093500; cv=none;
        d=google.com; s=arc-20260327;
        b=UulwNsQxHsaesomT4vShiNMyj1KANGDSBmv5DUd3FNsWqXKZRin9PH5d1ekRUkD4JS
         Yq9aXtjdSuvdZBN2RV7VnnMX3o6Mwb8C6WlsnCUWwnclbPBdVSjQcTU1OfKDcFD7qZaU
         +WGIUrpZ0N/OaqIZOlomA2Gg3jqPKCJiAhVDCjoPSMNAe1aviEQa8Zw8lqHQp0vzvyif
         ne+i/DE9aqD8zM3Bv6kcGtFW4I0sDGA0rKxJCkfH/zOnjiNw4vN4Y4oqGM2hGljmyW/k
         iN+6F+OwvXjiSl//jMbBd5yF2evUZpjqdOmGgFANQJ5vAcqb8tBGV9mIsmzVmyfPxoZj
         OcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PNFlsAXHWsQXFb1l/WhUw3SMUiQ78wfgHgQ/IQM+oo=;
        fh=tFAOQA8+4Ptlu9XrSgbJ+EJb41QoJI6rsXr5PPQgbBo=;
        b=qHw53/bLG5jkOoUKQVHs3f5hg8vKzKnubj788AGkCKbPQ75odDJV6P5eaLPY6aLzx2
         GqJX50DhUYuGWlU8LMf7CxRYTcbq5SrjcTJxDsSmhK7Di5h1R8kI3T/KZD+e6gRPF7aX
         x2luYWBSketVIHF5mWxv7Op2BEIKjklZGI6PmpQasRdtbvbDxm6Dw04DPERObxEdLgfb
         vDobmhpthkF9+qQMQeTkdOGB2LHGTqzrg9u/8qjYz8nxndz4gkMsEjxKN2ECXYomF0gf
         21Np8TLb4IAb+RmOhSPE9I15G8eG2C1UiDYmVdNSG/d4beQgZ1O02m+Je9/nmR6fk/i5
         w+Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond.com; s=google; t=1790093500; x=1790698300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1PNFlsAXHWsQXFb1l/WhUw3SMUiQ78wfgHgQ/IQM+oo=;
        b=bhopPWi6vU1yWbjS6Zq4gW2OIK+ORL3+RG1gFKHbreDBEwkWwlOD1NJZmUMPUU8lqH
         itVrk4XVi5re2OSqVyHaXTxn6hBYTcHWRKA1j0H3A0AuJkxijy9xcDCLP6BeFe/Ha/gU
         LESfzlAeB3pY/4Y8AD9E4WVvqm7OpjSUYTHCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093500; x=1790698300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1PNFlsAXHWsQXFb1l/WhUw3SMUiQ78wfgHgQ/IQM+oo=;
        b=cYSvcj/3bpoyC5UDAHSF8XxpB70bqzObnN6p3WRnWOJRVd7JVXX+sJnqu8BupWz/ty
         g9g+oy6r15+QGMfJ9EUgQnUrmsTf+etZDIwZOg0yFsKBAozQZ2pzaFnE59G08FikE6w6
         Yopgtws1SSJ8Gn9HxTZFjCFv7vXI3R3d/LxWe4g8LKSyff/bVGuQyx6ZYJUjuDB+BHo0
         FjYF+UuqfgNNmzr78SDvG01VIUqdivtiRAmDWm50fzAVhCHqnOfqg2HGsV2FqTxWS2xA
         OxdQNriJVbVyUpk0xy/p0Lx3ZbRCrG5fkTup8nU1CD3nMKCD5SMvNR6UKYc4m7NzWLI0
         gXyg==
X-Gm-Message-State: AFuF++lmlmTdf1e1d5uYn9uuTy4R5l7HVSU1WoHCWr7NJnLnqxccPlC6
	HilXzR028MTo3Lvb4VVKIGb5rN+I7husxZYU20SZxvslNaq/8lwaalC2H5orE6U2Apyxh1U2TwT
	J65kNs5p6OIMu/fwVWXNPZH2z1mgosKJ+XSjTjKpj
X-Gm-Gg: AYBFou2gOoQmdnIhlGpTz8+qGjV4x6qps+hjPptTQYBqrqgLYajgGzqSayytQYL/ajW
	5xGBmoXaH+RzJfl33z5hKfSldgdTgjLmJc1RwYtm64l4qkOACWHhBhQKYzVNNnjajEaN7FnMDbG
	Jm+YJkJR1h+HjP8SDWaKxTGAAaUjFtwzICKhWFNjPgYSYLFRtcMDGVumn5Dnn5R9gasYOC2PHMT
	eC9tJ00AyHwDZywBmYLg8qMetoX/R+n9Oh6q4inbS4XjlsrQeXTRZU1Bgs0cjxGx25hI+xpA40v
	Az9F/9m08Wrz1BsykDBQY9P4x6eqB3Ua2OWglJebDn5bZGaZHMEiFWlbh+vYc7coMzk=
X-Received: by 2002:a05:6a20:734b:b0:3da:15a9:a18e with SMTP id
 adf61e73a8af0-3ddec679970mr2166994637.23.1790093499587; Tue, 22 Sep 2026
 09:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com> <20260915081910.4142719-16-morbo@google.com>
In-Reply-To: <20260915081910.4142719-16-morbo@google.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 22 Sep 2026 12:11:28 -0400
X-Gm-Features: AcwNN1Wih6NtppTV0vkjzAIjWyWZSSKgTzjtdFf7g3_FVHt3mrWns3cWwRfW2oA
Message-ID: <CAOg9mSTFhVsyu-uHkh_L02nK63WBh4R7viAtrGx1gqkvnenUFw@mail.gmail.com>
Subject: Re: [PATCH 15/28] orangefs: Use seq_buf for debug help string generation
To: Bill Wendling <morbo@google.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I compiled your patch onto 7.3-rc3 and ran my
orangefs debugfs xfstest through it. The changes
look good to me.

-Mike

On Tue, Sep 15, 2026 at 4:20=E2=80=AFAM Bill Wendling <morbo@google.com> wr=
ote:
>
> orangefs_prepare_debugfs_help_string() constructs the debugfs help text i=
n
> a dynamically allocated buffer using repeated strlcat() calls across
> keyword loops, rescanning the buffer on every append.
>
> In preparation for removing the deprecated strlcat() API[1], use struct
> seq_buf to build the help string. This tracks the write position across
> the loops, allows formatting each keyword line with a single
> seq_buf_printf() call, and checks for truncation via
> seq_buf_has_overflowed().
>
> Additionally, replace the final strlcat() call that copies the completed
> string into debug_help_string with strscpy().
>
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Cc: codemender-patching+linux@google.com
> Assisted-by: Gemini:gemini-2.0-flash-exp [shell_command_run, editor_updat=
e_file]
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: "Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Matthias Schwarzott <zzam@gentoo.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
> Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
> Cc: "Martin K. Petersen" <mkp@kernel.org>
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Mike Marshall <hubcap@omnibond.com>
> Cc: Martin Brandenburg <martin@omnibond.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Chuck Lever <cel@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: NeilBrown <neil@brown.name>
> Cc: Olga Kornievskaia <okorniev@redhat.com>
> Cc: Dai Ngo <Dai.Ngo@oracle.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Kanglong Wang <wangkanglong@loongson.cn>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Qiang Ma <maqianga@uniontech.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Thorsten Blum <blum@kernel.org>
> Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Cryolitia PukNgae <cryolitia@uniontech.com>
> Cc: Jiaming Zhang <r772577952@gmail.com>
> Cc: Will Porter <mrwillporter@gmail.com>
> Cc: Cen Zhang <zzzccc427@gmail.com>
> Cc: "C=C3=A1ssio Gabriel" <cassiogabrielcontato@gmail.com>
> Cc: Rong Zhang <i@rong.moe>
> Cc: Arun Raghavan <arunr@valvesoftware.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-edac@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211@lists.linux.dev
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: devicetree@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> Cc: devel@lists.orangefs.org
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> ---
>  fs/orangefs/orangefs-debugfs.c | 36 +++++++++++++---------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugf=
s.c
> index 9f94919a6bc6..6e2f9887eab4 100644
> --- a/fs/orangefs/orangefs-debugfs.c
> +++ b/fs/orangefs/orangefs-debugfs.c
> @@ -37,6 +37,7 @@
>   */
>  #include <linux/debugfs.h>
>  #include <linux/slab.h>
> +#include <linux/seq_buf.h>
>
>  #include <linux/uaccess.h>
>
> @@ -623,10 +624,10 @@ int orangefs_prepare_debugfs_help_string(int at_boo=
t)
>         char *client_title =3D "Client Debug Keywords:\n";
>         char *kernel_title =3D "Kernel Debug Keywords:\n";
>         size_t string_size =3D  DEBUG_HELP_STRING_SIZE;
> -       size_t result_size;
>         size_t i;
>         char *new;
>         int rc =3D -EINVAL;
> +       struct seq_buf s;
>
>         gossip_debug(GOSSIP_UTILS_DEBUG, "%s: start\n", __func__);
>
> @@ -640,17 +641,14 @@ int orangefs_prepare_debugfs_help_string(int at_boo=
t)
>                 goto out;
>         }
>
> +       seq_buf_init(&s, new, string_size);
> +
>         /*
> -        * strlcat(dst, src, size) will append at most
> -        * "size - strlen(dst) - 1" bytes of src onto dst,
> -        * null terminating the result, and return the total
> -        * length of the string it tried to create.
> -        *
>          * We'll just plow through here building our new debug
> -        * help string and let strlcat take care of assuring that
> +        * help string and let seq_buf take care of assuring that
>          * dst doesn't overflow.
>          */
> -       strlcat(new, client_title, string_size);
> +       seq_buf_puts(&s, client_title);
>
>         if (!at_boot) {
>
> @@ -665,24 +663,18 @@ int orangefs_prepare_debugfs_help_string(int at_boo=
t)
>                         goto out;
>                 }
>
> -               for (i =3D 0; i < cdm_element_count; i++) {
> -                       strlcat(new, "\t", string_size);
> -                       strlcat(new, cdm_array[i].keyword, string_size);
> -                       strlcat(new, "\n", string_size);
> -               }
> +               for (i =3D 0; i < cdm_element_count; i++)
> +                       seq_buf_printf(&s, "\t%s\n", cdm_array[i].keyword=
);
>         }
>
> -       strlcat(new, "\n", string_size);
> -       strlcat(new, kernel_title, string_size);
> +       seq_buf_puts(&s, "\n");
> +       seq_buf_puts(&s, kernel_title);
>
> -       for (i =3D 0; i < num_kmod_keyword_mask_map; i++) {
> -               strlcat(new, "\t", string_size);
> -               strlcat(new, s_kmod_keyword_mask_map[i].keyword, string_s=
ize);
> -               result_size =3D strlcat(new, "\n", string_size);
> -       }
> +       for (i =3D 0; i < num_kmod_keyword_mask_map; i++)
> +               seq_buf_printf(&s, "\t%s\n", s_kmod_keyword_mask_map[i].k=
eyword);
>
>         /* See if we tried to put too many bytes into "new"... */
> -       if (result_size >=3D string_size) {
> +       if (seq_buf_has_overflowed(&s)) {
>                 kfree(new);
>                 goto out;
>         }
> @@ -692,7 +684,7 @@ int orangefs_prepare_debugfs_help_string(int at_boot)
>         } else {
>                 mutex_lock(&orangefs_help_file_lock);
>                 memset(debug_help_string, 0, DEBUG_HELP_STRING_SIZE);
> -               strlcat(debug_help_string, new, string_size);
> +               strscpy(debug_help_string, new, DEBUG_HELP_STRING_SIZE);
>                 mutex_unlock(&orangefs_help_file_lock);
>                 kfree(new);
>         }
> --
> 2.55.0.1032.g73a4cd73de-goog
>
