Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAF346FA7;
	Thu, 21 May 2026 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355280; cv=none; b=PVzsvtt+AOWv1MuwjbLUMB7khmVkVngYbwcttGSMMwcaFUPyZcY9Wk7dpB5ma4BT0z7Ds6HwDFJnThj7JHkAYsviqCHD5UwuU74AHlKTaXNkJx3xPYL4/QUJAXEPIV1EH0VC13TxGRfJv8WpYT5fi7hmEK0eNOZH3YqdYyziqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355280; c=relaxed/simple;
	bh=xLdvccmr5z4J1a1jPCxFWtvAxTh3T/Q+WufngXkj9cM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sPoqMuOC8mVuMbcqQSomY9PhmtobfIuFxNbXKjeMw+fSAtM2gyCK1hHPEgG+u02WLlWXWbMFF1lLTSrbHaoTm+koHstlf7UaD7hJzsLQCc37sPm/s8GLDZKFnjqoF6hUmW1juFhFKJW4fIw8uB0NUimiZS75I0HAlABm8sEAjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=F5ejE0o1; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="F5ejE0o1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779355240; x=1779960040; i=spasswolf@web.de;
	bh=ql3+0hj6xNtbP63u34kpldwA0MS4zltmhQm9KPsSHZY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F5ejE0o16TL885xTB2pgbAUeCoEC4S5Ac4SDJJeE9HMUj7457l+w9jc+MGZH765l
	 NJ6TtgbhYXxgjsweaIntHz0GSgLNPF7FQefHFoCM59ruinuK8GEEs9fEQnrCcngGU
	 DURgeVKXXtAXB1J4HQ6hezismznf9UXDs31QCh8249I4K1DwmX7PFh3mcZbLCxcIc
	 ROofj7OrpKbTtVrqZV7TPKYuqDllxgDlOehNkJGhNujO4rxVD5JUq8GgAcNGGd+Fo
	 Ygl61HMuZQCus5eag/CqKrXhUhiDVqF/0MGga3yTkkE2PDSzRwpH49BXaCYaOOF6m
	 7u/PBI5b3Tob5X3uGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCqb-1x8iO720v1-00pt6Y; Thu, 21
 May 2026 11:20:40 +0200
Message-ID: <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	adobriyan@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, spasswolf@web.de
Date: Thu, 21 May 2026 11:20:39 +0200
In-Reply-To: <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
References: <20260520225245.2962-1-spasswolf@web.de>
	 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
	 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AEeKI4Le+kMvqOquXFzC2pSQSZjRk/Mpc67dqw1V7IbuMRGiJZw
 JbgX2UBcvkYmx4aiS09ZFJWdZ2sNqnRQoxLs467bi0wH8znRzBVfLzls+iPnTIZOcEsGxim
 MhBtlDw8FyYSRo7jVTo4nmTfptTe1FgJmu8MFcUbWCJVH+XJCqp0l+/HHYIReCvM7AcrrEx
 j01ytqmVVbCJ2jmgPO+DA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FwhCoO/lCHc=;hMfPf27XmZXjMjCCF2tTFAjAFAM
 Iags/dN82xTIxd+pz+wVx2V2Y3BEvNp8umtPy8Nyr20BKjsm7IsQvOIaDc17l6BT+lgS68Myt
 hz/cu+DPaOrbMVZKJ51jmNwOdrfq/8dhGINDtrJTrubNfMApC5sa2IKn27BcizvTsAbpTwQYA
 O34744zZLJgQQxJ6SvQEr9+Bgbgkd5q3jpR6P/y40ERkKlPq4/BIURFXLFFF5OmyBlkDCMlND
 9chUqAYrMjgELEPfETTbqg9aGmPZNYXrJQOCYrsTVXHIRYtVxQtzy2swkCn0tyy2q01LrCYuD
 n6tAHSfCco8H4KtJBs8IDwtWLVipRSTARswdT4yR1tpVUFb+jD4s7vAebJkwCXjnMg5buG+Co
 cXN1jB1AbqIGYnnQTlc/Il/9ZrMseRzFaiZFoNDitJmkAqGt+m+PV4D6RRWQlOWG3XbAU8LrZ
 hGl1fwMGoeR7Pz2B19KLwpf45YT1CJcW+g7X31wkFqtqjzOborPqGrw/1lyM8nKpcFasJIIJ2
 QR3fCFg6vfx+PoM1cEopHQae90FxAIZLFpZk0JC7mhb9xwDNki1yX/t3kw2zuSRcxj0NFTkPE
 AZ/YpHE0oYvgGFiJTQbn4GVXHALQzt+lAatDccOZskGljYp7dLujQE0e1zloMCu3NjX80LMl4
 0Y4uSKJ34KmNbRZZ/3k9IdlMiTsLafyJAZk9qqU5wIBFUBhPoQsiWd40E1CQgh1M2yYqucD1C
 3PkKHCTczKMrR55JNHkrJ1aXcb+AlEcU875nvrqKL8RrgZJq+tG+VdO5QNrSmPNSZLLyiWWQJ
 9zjGryv2cDf0K8LemffQaCti8KuP8d70W1Qy126oVLi4Z+pjSrhr+3d8nf5VrGZXxFYLJlhEi
 4Z2YFYt/lCnCgnXsfuy2fOusRNb97t+VHx3+M7k6XOub7Y6ntWeiZk6etQyFgbVZKVsvsnJos
 5huD/6nOHTpz+queZE/0aG6o3PtlqYs7Ow/ntR7bUw/yOKJ9y4dfhoNEXylpRv+ceKHPoIuTI
 BRMezGdFnLx+WTwgYBaYtwq6rEy0xjBcw9Jl0SZLzYGz/6vpOhNfeW7t1ka0n6DYurVLDmIrZ
 5JGmn/IMQi7Z3qutxLBZqUZE4IYyioy+cyHcYsy101ds6MO378Kejgv+fN1fGepmZV5VVHJ2h
 BlPEghy6k50j4cgZZLGzBh+PWYcZExb8bRE9piOD80CkhzNVpLSD29wb+heSujfhs1gvEQuZ3
 nFgztPWuO/6bdBFSLmKlK6nPFxWSCOu2cMdrwTT9rpLGtbBXHQSgjCQKA20jPG8LYYasmEYnZ
 ARqbxsqFRAVk3pa1LUoRMxVakptJqd4cRUbotXCePiJzHxdE012s6s0cWQ+9MnhRDOW8IaxNU
 OKWK2fnredzSlh6+5MSVY5CqZwQtKFyJS5pucDjdS1RaPn52nRElPeKAe3kyljFprPzWGsw5G
 o9anO31OVzOEXbeRMopbwBQb3uhrMIc0eKNCewzXLMN7eWtncGji1elIU0HWBf6wToLmNietE
 FKqQ+zvnl2mm4WBYA3dBofaSmlsvonCl91nTjAe8pHl/w0/DGV2VwrPrkWiamzydfVw8UE0As
 ie+uQWZoWoX95FkiWdabPbpzdsehj80zrKJG4yBx4inUmSjWP96o+3ozTbLX8MsF0SeMt6BVj
 6gK9jT+kAiFPETR3WpS3KNhkx5TKTLQoYrBvQDSQ0JsufqEhJCJrCzGJ02JRaA9Fix0hk1KsC
 64H0XJksn4l2kMgKAhYFke37alXOvRJbCmCBulFUrgBdhbqkMTx2Dj8LOukGCDsi0CK8qqh4j
 SWQsQv+R5ai08PwZotEUGp1Q7wLGjQYqb/ZNUjfUH+7RGsxAJkx2Yd+KEh+tmydYRtwqioBoG
 pDTIZbHOpvrA0rhF8yTdc6AhLpffClirtLpyru28NeH6dcFaYeJWvcKXcBdqA4qXg3HmrB6AF
 GDbBPyTTRgrsuPfStNxMRAyDJYr6JFArgpnZYqFn5Nl/fMmLVi+NXRRzOSky6fGU6Wb3BHaQX
 TuC3X8akf3wauq7GqARcWdA4NFGoR6PZxMDSVBTBl/SFBHqqt2gQm03K8/plga7yh7pKNKxx4
 W/tJUUzIM6mbqCI5G8q+mPm65cI2qg178zmlxDwSlomiyv7emPZlrWTVFPhruXKsT0xGk0LaY
 BTmkcbiGT39L1x/BaRE8N6cjl7bDz+DaO6mAqxCcsVvvVsDjc1M4ZgIHKROU45dmpZ1ysX8cJ
 GpPDeAKCcO4p6EM8hLgVa+pxJtI7R+1z0DB4gYXWQbJDlaunNJxSRmYFzqBqR+g3e48BTn1Ve
 1lmWC2S10KP5bU7oyG569pXjxGCFdR4/Pfib4focwy17zDD5PQfkb5cqzcP3PxhIDWwS8X+dV
 Z1+9QV4Sz9x5YXIAQMjKyfh/ilF7l7S06RCTYYRq7/GYQqzKynft4tCzw+s4QnZqNKCC9A9Ql
 mNvknL61fKslIP06A0aaWWK/8FCWT5dKMpDUF5sKVJT0KikHKjY0phgCrR5LOt7coL6GTlIP+
 +yxkQcYiwyJlsKtnAMH4oOC6XdoRiPPqciRMLybuqD3yZchcPz5VSF+P8C3mnsCd0CY+Henu0
 zvkXaiUMR+KGgcDOt/zFYQi5JoUrYNERK2KER5MPIdDQmOXSJw7nuAewua8ttBqktRwvxG6cy
 g/2+2ZIxXlkMFrMmyrPZlKZHZDsH+mvVhua67OybrLKhLiCKJk8gZu5NTVkZzuEfAxa6kg+OU
 XvhNAjvPfwrLlj+gEYWIQRPuuCgsOK1Eh4KUWS47v6v1tE7jDpxHKQK3BWlLU2Q+jLsrhI2nO
 NknG5rzCMA59R/4ro/oUwNpGSlidVpFNKbWxB5gWqFtmP6niuTjQ2Hys0kjBnkk1SS6kNSklo
 PtkYGrL+hjbH4fBNc7WiD7VLAuXb+4892QRWT6X5IaBXHH64Fl7VEvvwmZBHGnMFG53QU8jUY
 /PnXgPF4ZrtKswXXOcFnVL2PvgG84FIUF7llgY94Ej0fTQzAav3Vs6JYXmhmRsE0fLPk+l2Zy
 8BgQyj+2wN1OIUS/CJuzTHy9wgEG9IXHcWW6Um2QBrrPmSexTRUxzCpirNTe+gDJH++hOahWd
 L76DCD+Ak/v4fDxnGKHROBbVYB5I49Ws/F2WnQrd0IhL8m8PtMP7e4PoRdN/aSvS32Y9pGcg0
 9Ln+uXZmjjBibcxYJyC78+qoUWDdkSHXhKPGlaZp4s/gWJO8QcMrqbBoWN0kVzRhsW930zOWZ
 BYL4WWBHlwZzg3/U7L+eqUn/7PVtYQjD6C0DOgnC8DIVYEO+HH8x0O51qEKfSAW4/EgNp9jCd
 uCn9rVUZqklEnJsnFF0kl1YwEb1xJGZk5jr9K1A8proSmK18jbKFIYqRHUs0c10laRYU88xfa
 9ebbpeCrtAqrAIW4BgNhHlyvFsKnrEMihJmAAtu65AvpzriKjs5jb3D+2qPXVG+/WbbzFLUoX
 iLD2eIMf+kpLEeMWBb2M3xKW6cWtSwFLf5MvYr4N0ZAmluic55a3o/2g7UfVqCWfrwMjbKWvK
 eXtuJZSWkjBeMLB7U4amqfic+pQDH82ad/HyiBvC/xr4GdzZSPFCwO6CAOOq/Otvlgz4WzcW8
 eSEp/PrUWWZ9Lqnb0uU4KyCJ3HN51L70NE3YLivvpoSoJ/N8j7uFeuuyu8dHIETsBu2whGkq4
 3YiArcEA/FMNfZ1iEI9lK60UeSwq8C9h16rauPTVgGuydWMdfGQmr1CUbQ441v6ppkCmsgEla
 1mA4Cv9bOo14Jat+UG037KkEio824heZw8Kni2pWGLfox/b7d38fsaywtl/LTx7coNF8v+N11
 7K+wZuECPF7zNqMZ5SmszaDEHA59wcfiZRy5rCe6AQysz/jqH22xffh2WPg+dtBD7k2AOipEH
 qEdjEIwB9y63zpe3lvv+wLeXDG5fF3nqfs3lVgEj94MAobwPD8pH45u2AsNTcx3ks2UbTb1fa
 hhk0eP/DmU7wCS84Z5GNspMHaPundcs7kaspODDj2C38X65FaqN4ovHbbNA6gchtS4gw5mCWW
 feM1RFquzbuLBUIXN24bfjyouDOj9glfPes9WbFN9kWGXn6L11tejds2wKVRryiBkkWAilgDt
 xoP5THwXC7XsMOSXc25QKH7aLkYO7BNNrqHYYD0xIrdp3FvGjnV+ujdAZGG8YCnMbWMT0Sd4v
 plxXtctdF84+iqH/B5kF9YYKb3SdljT3bDJrjwun7pKewYS3A+egumiM/aSJ9IiYN4UFDdRl3
 EiqL1lxEKApDEQwIdGqiGs/qeq+6tyDnJ3bhqjlTF5ynwkMi22kKuHmbdZgzKf6cFCMpcpNlg
 TwgAlZM0OePSagp22Yy/NJoiysFHM/FqqK6L6Tx8GBmqkX9eNRhHsG+T5i6smGBRiGlImsC3j
 ydATMxTRdpuVb1XLJFI0f8MAD2m27o+8o7H0HMs0GMIQ1xxOXfjqWbfLxr3tqEoP2RCGJ32h+
 YepmtV93US+7qlIz1QszUMNhxwOeYLWtEsJwIRU6FGGZqzS7gF1pz+njP/YcMsfN0zj8iZRjx
 KsXirBn7OMiiAQxj3CNRhDhuxz0yB6qthAbaRgbFGWxGkr/l7CEfHYI+MtjjxK0akOWHaxZg8
 2LLIdBx+ui/yu+JfItxXIu4c4jwchkTalhKKB/QPQdU9JxZLbdZqK+MU92SC5x/EcUkO0ZMzJ
 WV2isa3tCEWDwKQmAo5d6IANRIF9/beRrHXNwawVxJp16oT4yLsouIsH7VifDXhNYZVjcc2oc
 1OwLe52jxTiT8/V4TW80lfLuVrpUNyEZ8SItxCmj63f10rZIKIFACI2nYSDRB2Bmhr+pln1MM
 xd4oyl4EJmsqACqVEWnbrFF7UuJnSEqQbLOssmxre4IgnS6zNZxp2fHzypxZXSbDjGC+WJDfM
 VplCccbwf17N7DYF5jMVMtIn9FLmXAzqJXhHTGq01kWBWM+x6o8k8gdxG1pttMtAQfRglbJVo
 pQPnilf2WWCUnKLLkam+mcQA4krWc+5ZXPJwUVPomGW37FnH5p55miN5oVy9lwOYfA31tfyqn
 KmiY15WIQ3y18zMNiYNTKl4o/QznCbaCqx5Ulmt15tT89yF2T0DgkimwkA4ZXb7a/8t8cDj2D
 FLicdoV4qrJLhdYnP58Lz4A2WA0HjIJNyMxNTgul5lLhh2PzzK9hE1KvyDs0S6tlHbaGm88oy
 shyDqbat2eLhsZ5kRwqu5y291DbdqmfxxnN+AORUJhywi9Eg/vaY2jlutfATYJQABiyt9rLfx
 U8CtHg8LXJkWYDy4pr5enqggzlNQwrKU2wFJmghCCMK5VyUzG1FawE8K9OXfeQrrKWj55isRR
 LOWNRVZ5ZLuHwtn398NT50DubybrGs1n7J41IxddMIGcxjRpxtiTduKjsJjTG1Zq5a12woyR1
 blZgEMR2OswjZh/VV9FGUZtKR01OHrzJHsMhVvCzQOgNZoHFWzhQsNYtlDCzih7XkUQ5NWJtc
 aosKaYlLwqZgDUGZxJCkOwuS6seJNO9VmthI67Nr+u2J1XYRbraOET3u3eqJTAlKneRfneGGY
 9xZBc6bqkgcOR410bkzxtt1nqNIKn2cM2hf7EJFNqKs6o8iFg6yViGLiVFPdsM6oIOdKuSQu3
 Z/ghEkHLw5w2nlab9s=

Am Donnerstag, dem 21.05.2026 um 11:09 +0200 schrieb Mateusz Guzik:
> On Thu, May 21, 2026 at 10:53:03AM +0200, Mateusz Guzik wrote:
> > Christian, can you fold this in please.
> >=20
> > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > index 771fc31a69b8..8f17c0abbc95 100644
> > --- a/fs/filesystems.c
> > +++ b/fs/filesystems.c
> > @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_strin=
g(void)
> >          * Did someone beat us to it?
> >          */
> >         if (old && old->gen =3D=3D file_systems_gen) {
> > +               spin_unlock(&file_systems_lock);
> >                 kfree(new);
> >                 return 0;
> >         }
> > @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_strin=
g(void)
> >          * Did the list change in the meantime?
> >          */
> >         if (gen !=3D file_systems_gen) {
> > +               spin_unlock(&file_systems_lock);
> >                 kfree(new);
> >                 goto retry;
> >         }
> >=20
> >=20
>=20
> Even better, I got the above fixup + some polish listed below:=20
> - removed an extra space in newlen calculation
> - the WARN_ON_ONCE case needs to free 'new', not 'old'
> - there is no READ_ONCE anymore in filesystems_proc_show()
>=20
> goes into the "fs: cache the string generated by reading /proc/filesyste=
ms"
> commit.
>=20
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 771fc31a69b8..712316a1e3e0 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_string(=
void)
>  	hlist_for_each_entry_rcu(p, &file_systems, list) {
>  		if (!(p->fs_flags & FS_REQUIRES_DEV))
>  			newlen +=3D strlen("nodev");
> -		newlen +=3D strlen("\t") + strlen(p->name) +  strlen("\n");
> +		newlen +=3D strlen("\t") + strlen(p->name) + strlen("\n");
>  	}
>  	spin_unlock(&file_systems_lock);
> =20
> @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(=
void)
>  	 * Did someone beat us to it?
>  	 */
>  	if (old && old->gen =3D=3D file_systems_gen) {
> +		spin_unlock(&file_systems_lock);
>  		kfree(new);
>  		return 0;
>  	}
> @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(=
void)
>  	 * Did the list change in the meantime?
>  	 */
>  	if (gen !=3D file_systems_gen) {
> +		spin_unlock(&file_systems_lock);
>  		kfree(new);
>  		goto retry;
>  	}
> @@ -321,13 +323,12 @@ static __cold noinline int regen_filesystems_strin=
g(void)
>  		 * generation above and messes it up.
>  		 */
>  		spin_unlock(&file_systems_lock);
> -		if (old)
> -			kfree_rcu(old, rcu);
> +		kfree(new);
>  		return -EINVAL;
>  	}
> =20
>  	/*
> -	 * Paired with consume fence in READ_ONCE() in filesystems_proc_show()
> +	 * Paired with consume fence in rcu_dereference() in filesystems_proc_=
show()
>  	 */
>  	smp_store_release(&file_systems_string, new);
>  	spin_unlock(&file_systems_lock);
>=20

So it was commit 36b3306779ea
("fs: cache the string generated by reading /proc/filesystems")
which caused the problem. If I had finished the bisection properly instead
of cutting I probably would have noticed this...

So I tested

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..8f17c0abbc95 100644
=2D-- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
         * Did someone beat us to it?
         */
        if (old && old->gen =3D=3D file_systems_gen) {
+               spin_unlock(&file_systems_lock);
                kfree(new);
                return 0;
        }
@@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(vo=
id)
         * Did the list change in the meantime?
         */
        if (gen !=3D file_systems_gen) {
+               spin_unlock(&file_systems_lock);
                kfree(new);
                goto retry;
        }

with next-20260519 (no RT, no LOCKDEP) and got no crash so far (4 boots on=
ly though (next-20260619
crashed in 2 out of 3 boots without RT)) but I get this warning on every b=
oot:

[    2.793416] [    T331] ------------[ cut here ]------------
[    2.793433] [    T331] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
[    2.793434] [    T331] WARNING: kernel/locking/mutex.c:625 at __mutex_l=
ock+0x586/0x10c0, CPU#17: (udev-worker)/331
[    2.793463] [    T331] Modules linked in: amdgpu(+) hid_generic usbhid =
drm_client_lib i2c_algo_bit drm_buddy hid drm_ttm_helper ttm drm_exec
drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp d=
rm_display_helper drm_kms_helper ahci libahci xhci_pci libata xhci_hcd drm=
 nvme
scsi_mod igc usbcore nvme_core scsi_common video nvme_keyring i2c_piix4 ce=
c nvme_auth usb_common crc16 i2c_smbus wmi gpio_amdpt gpio_generic
[    2.793518] [    T331] CPU: 17 UID: 0 PID: 331 Comm: (udev-worker) Not =
tainted 7.1.0-rc4-next-20260519-rcunortlockdep-dirty #465 PREEMPT=20
[    2.793534] [    T331] Hardware name: ASUS System Product Name/ROG STRI=
X B850-F GAMING WIFI, BIOS 1627 02/05/2026
[    2.793547] [    T331] RIP: 0010:__mutex_lock+0x58d/0x10c0
[    2.793555] [    T331] Code: 4c 8b 4d 88 85 c0 0f 84 f8 fa ff ff 44 8b =
15 ca 9b 81 00 45 85 d2 0f 85 e8 fa ff ff 48 8d 3d 1a 57 82 00 48 c7 c6 a6=
 51 9e 83
<67> 48 0f b9 3a 4c 8b 4d 88 e9 cc fa ff ff 48 8b bd 78 ff ff ff e8
[    2.793579] [    T331] RSP: 0018:ffffa497016c3510 EFLAGS: 00010246
[    2.793588] [    T331] RAX: 0000000000000001 RBX: ffff88c33a4c2ad8 RCX:=
 0000000000000000
[    2.793598] [    T331] RDX: 0000000000000001 RSI: ffffffff839e51a6 RDI:=
 ffffffff83de3c00
[    2.793609] [    T331] RBP: ffffa497016c35c0 R08: ffffffffc0a55d92 R09:=
 0000000000000000
[    2.793619] [    T331] R10: 0000000000000000 R11: 0000000000000000 R12:=
 0000000000000000
[    2.793629] [    T331] R13: 0000000000000002 R14: ffffa497016c3550 R15:=
 0000000000268000
[    2.793641] [    T331] FS:  00007f1f32e5b9c0(0000) GS:ffff88d23b2ca000(=
0000) knlGS:0000000000000000
[    2.793653] [    T331] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[    2.793662] [    T331] CR2: 000055cdfa28f588 CR3: 0000000112e73000 CR4:=
 0000000000f50ef0
[    2.793673] [    T331] PKRU: 55555554
[    2.793678] [    T331] Call Trace:
[    2.793683] [    T331]  <TASK>
[    2.793687] [    T331]  ? lock_acquire+0xbe/0x2d0
[    2.793696] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
[    2.793809] [    T331]  ? lock_release+0xc6/0x2a0
[    2.793816] [    T331]  ? init_mqd+0x122/0x190 [amdgpu]
[    2.793902] [    T331]  init_mqd+0x122/0x190 [amdgpu]
[    2.793961] [    T331]  init_mqd_hiq+0xd/0x20 [amdgpu]
[    2.794015] [    T331]  kq_initialize.constprop.0+0x2b8/0x370 [amdgpu]
[    2.794071] [    T331]  kernel_queue_init+0x3f/0x60 [amdgpu]
[    2.794125] [    T331]  pm_init+0x6b/0x100 [amdgpu]
[    2.794178] [    T331]  start_cpsch+0x1d6/0x270 [amdgpu]
[    2.794234] [    T331]  kgd2kfd_device_init.cold+0x7b9/0xa1a [amdgpu]
[    2.794365] [    T331]  amdgpu_amdkfd_device_init+0x190/0x260 [amdgpu]
[    2.794444] [    T331]  amdgpu_device_init.cold+0x1952/0x1c79 [amdgpu]
[    2.794556] [    T331]  amdgpu_driver_load_kms+0x14/0x80 [amdgpu]
[    2.794622] [    T331]  amdgpu_pci_probe+0x1cd/0x440 [amdgpu]
[    2.794684] [    T331]  pci_device_probe+0xc2/0x1a0
[    2.794693] [    T331]  really_probe+0xd9/0x370
[    2.794701] [    T331]  ? __device_attach_driver+0x130/0x130
[    2.794710] [    T331]  __driver_probe_device+0x80/0x150
[    2.794718] [    T331]  driver_probe_device+0x1a/0x80
[    2.794726] [    T331]  __driver_attach+0xb9/0x1f0
[    2.794734] [    T331]  bus_for_each_dev+0x7b/0xd0
[    2.794742] [    T331]  bus_add_driver+0x11d/0x200
[    2.794749] [    T331]  driver_register+0x6d/0xc0
[    2.794756] [    T331]  ? ledtrig_usb_exit+0x880/0x880 [usb_common]
[    2.794767] [    T331]  do_one_initcall+0x57/0x3a0
[    2.794774] [    T331]  ? __kmalloc_cache_noprof+0x323/0x3f0
[    2.794785] [    T331]  do_init_module+0x5b/0x210
[    2.794793] [    T331]  init_module_from_file+0xd4/0x130
[    2.794802] [    T331]  idempotent_init_module+0x100/0x300
[    2.794811] [    T331]  __x64_sys_finit_module+0x6c/0xe0
[    2.794819] [    T331]  ? kmem_cache_free+0x1e9/0x420
[    2.794827] [    T331]  do_syscall_64+0xf8/0x6b0
[    2.794834] [    T331]  ? lock_release+0xc6/0x2a0
[    2.794842] [    T331]  ? kmem_cache_free+0x279/0x420
[    2.794849] [    T331]  ? do_sys_openat2+0x80/0xc0
[    2.794857] [    T331]  ? __x64_sys_openat+0x4f/0xa0
[    2.794866] [    T331]  ? do_syscall_64+0x1ef/0x6b0
[    2.794873] [    T331]  ? do_syscall_64+0x1ef/0x6b0
[    2.794880] [    T331]  ? do_syscall_64+0x1ef/0x6b0
[    2.794888] [    T331]  ? do_syscall_64+0x1ef/0x6b0
[    2.794895] [    T331]  ? do_syscall_64+0x1ef/0x6b0
[    2.794903] [    T331]  ? lockdep_hardirqs_on_prepare+0xd7/0x180
[    2.794912] [    T331]  ? do_syscall_64+0x38/0x6b0
[    2.794919] [    T331]  ? do_syscall_64+0xad/0x6b0
[    2.794926] [    T331]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[    2.795281] [    T331] RIP: 0033:0x7f1f339b97b9
[    2.795620] [    T331] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f =
44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24=
 08 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48
[    2.795936] [    T331] RSP: 002b:00007ffe5b4ce6d8 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000139
[    2.796219] [    T331] RAX: ffffffffffffffda RBX: 000055cdfa2b8a20 RCX:=
 00007f1f339b97b9
[    2.796490] [    T331] RDX: 0000000000000004 RSI: 00007f1f320f644d RDI:=
 000000000000003b
[    2.796741] [    T331] RBP: 0000000000000004 R08: 0000000000000000 R09:=
 000055cdfa282d70
[    2.796986] [    T331] R10: 0000000000000000 R11: 0000000000000246 R12:=
 00007f1f320f644d
[    2.797227] [    T331] R13: 0000000000020000 R14: 000055cdfa286d60 R15:=
 0000000000000000
[    2.797461] [    T331]  </TASK>
[    2.797680] [    T331] irq event stamp: 160663
[    2.797897] [    T331] hardirqs last  enabled at (160663): [<ffffffff83=
5c6cbf>] _raw_spin_unlock_irqrestore+0x3f/0x50
[    2.798125] [    T331] hardirqs last disabled at (160662): [<ffffffff83=
5c6a7f>] _raw_spin_lock_irqsave+0x4f/0x60
[    2.798350] [    T331] softirqs last  enabled at (160282): [<ffffffff82=
ac9888>] __irq_exit_rcu+0xc8/0x130
[    2.798581] [    T331] softirqs last disabled at (160277): [<ffffffff82=
ac9888>] __irq_exit_rcu+0xc8/0x130
[    2.798806] [    T331] ---[ end trace 0000000000000000 ]---

Bert Karwatzki

