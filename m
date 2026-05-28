Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72212EEA8;
	Thu, 28 May 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991196; cv=none; b=uia0bWpfTZK685+4fWUeNqJdhkOxrS4EzmLaxkOfcpNkoOfod1Ze41JU35WRGyhd64gqOrs4+1yLISMC4mLwpuKfu1aqd11beRKfw6bNQUjHReYcLw56gJGqx00BB5/f8ha0xbQ18L0UTWGjZeh9HE/lc0/xcTcg2pYUOEOwzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991196; c=relaxed/simple;
	bh=+t2uBMRmJqWbe7EEuTbwr1yRQbqM/ioHiPLugIxF0RE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rcho8WnCx657qPZmH+gv1SF8aM3TFrRxU0B3fq94t78viFn0kIdemVjh5oYoCVDOpi+/nOM10N7FMGsY/kqDxOid+AtL4zfip6RIuAF9GJ44t/FDDDHMGSILRyY7qXMfQ+Hob/f77wH4A1+x/6lwKD6I9v1Bw6BtLDoAAQqpUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=tHUGdmUV; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="tHUGdmUV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779991172; x=1780595972; i=spasswolf@web.de;
	bh=+t2uBMRmJqWbe7EEuTbwr1yRQbqM/ioHiPLugIxF0RE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tHUGdmUVuAbkG+fY6ZCY2EgNnl/Ps6LOdMcloY5zY/iW/OQPOsgeV91QlYLFA0vS
	 WuMri366Seza8nVqdnY4Ct3tsIZdi+iEyBNJ6JKsmgf9dC+kJiDRWJNUPzYq/q69w
	 CytPuNzoBpLlzkkqw3FxjXmS7OiaS36XHSN5WlP1dU7i/KrIqdc8knkLvQxnJv64s
	 sIlAjc41cRSMzZ2KmlmGBFgUo5I2q5USPCak/3nSXfEFc3qZ8bdE4cDft/yotvLFO
	 azuGcMVAxhcktONqt+r/Iv+AuWFTR5xfBW9pdNpZU4FLHsMPtsmwEE8cEzr9xIHCM
	 9TYn6oS6GKyQuxT+YA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mrfp8-1x7HAe0ZLI-00oWDW; Thu, 28
 May 2026 19:59:32 +0200
Message-ID: <7e8f3a515208583d06c9b5ca18a3e007a8c6b692.camel@web.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, spasswolf@web.de, Christian
 Brauner	 <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, 	linux-rt-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, 	adobriyan@gmail.com, jack@suse.cz,
 viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alex Deucher <alexander.deucher@amd.com>, 	amd-gfx@lists.freedesktop.org
Date: Thu, 28 May 2026 19:59:31 +0200
In-Reply-To: <CAGudoHEX=Su_ehV8nNP_6Onfh=hB6uiyTTCojR7nSOkEj6zh4Q@mail.gmail.com>
References: <20260520225245.2962-1-spasswolf@web.de>
	 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
	 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
	 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
	 <878q9dvzh0.ffs@tglx>
	 <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de>
	 <CAGudoHGk1CP3gRQLCV85AFHKx6vBEyKySOn4J+AZVAP2FkrN3g@mail.gmail.com>
	 <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de>
	 <CAGudoHEX=Su_ehV8nNP_6Onfh=hB6uiyTTCojR7nSOkEj6zh4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:00WSvhz+TDyJCaqT65o7CCHgLmuLFFgzuy688cx9TWJOtR7WSeO
 /Adyo5OULwI9pS52bPv4SUA+xnfypCdp6Ap7XbvO943ita7f6nia4PPRjIeQwCWBgDFgeZE
 Dx+dI77s4rKPl+okHBYsOvVZdhmys4xXyb8rdhhkXkTvHHJ22CBmNpvFjssCC8tfthZZxsC
 Mml2S5umvfUpB7S2Du8FQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PbM6UiLJT3k=;vWaKiJNlmb0UTjzm/mzok9hxmZu
 F1W3KxhTPf3tabq7Y0jNDPU95hku0FyTYU2AK/t5xMSNrGKyNVnOLxZLlVIGWwmQadFmFtrU2
 pQLceIFVoncmhacAKI5zOtnDe92p+0OPcYcba22al4ANpZy7MqkOkrBci9461mPWx0UWg+1e6
 wUTywLzYLdYLb1hufaXbYP14D+manmS2qxubUoIzrVFCMTX5xCFKdWUS5YS4x1deMForr07Ia
 W2UDr8Jcekzol+WtUdupdkyMLwh/C1dL7UOF3sY5tEOGywI+5m4S5o7sxWRzoDGCdv+hyjzPw
 nFWybqGoyayvhvjZiYoQpTPTdQKXR6lw2HWYHbYnWeApnkN50yIyatnnfxxW8f+IB129Rbtcq
 KsgMDSbjkoWp0U9+n3MeBl7lK0kYgaCfKXvkpKbXuPvxQisNGO+kczXlRN7qjufCmXuf5ITln
 kCcFogQ4lhkb3aSx2/54bio7SsAXsDTmHWPhCpIEwoXbwQmgWsoGkV3uWYDH45+UBq1nYOX5s
 hOEwg8VZjVl1Am2BJ7ShZ+Hb1JtlsyLLJ6X+bNQs1FuZOoDDbnJDa7E3aBhIvQKKUkmEuWcT+
 UPVt5FswoF01AEZg2o9Ytzn4dTFz2g69Bj0NYZkBi4o6vAhMgLl2LndPff98D3VwOfVDPokVG
 BFNCd+4+Pceywp7QBMB+Zf1aS3EK5n2Yih95rS9KFwNMxqflaPn/177fxcdZ+I0g7bFR22mAi
 gEGcdGcDMmdxW/3XV/b9Mn0Vzo7W42FeY7THpA9i2odMkbjko/ImEDpJETuDg2u6zOEDor8ku
 oX65I1wDblGJXsNyNK/PSGt/GG6+7GrUy6fWEKuGLlIT8mimT68NCMtASlYAGDvc8W0/G+MPS
 Tf7nThCLZ1XXY/WhaMhTMjiQZIjwo8sjcOCHuTZ2NJY9xlsOgwhuKKgN1+EPjLBmmjtCY5JZk
 +6N78Pxpbx4XEka3/54VfMUpBLUqsx32tVNgqHt087R/KNYchX1CwEt6dotyo06OIRe0HuewI
 90Djt/jZoPJzpK3ZMUMd5l4SAirYo1xrKcpU7EziH8L0k8VYPyZiroeUvAkL0xhFN+ZQGEFo1
 RGR/wvLPNfHdYt2ZrdWCF+tuH1jlKU23WgZo6mmVw9iSE4ex25UvKrJLqiYoTQXHKSI3s6q6J
 uEW2LiDY9eRpa3ugagbM7UmgDi4ax8tFYjGholsTV23gu46+t7AcRkUzePiPNsEcJEb4d4A6k
 sulmEs02riODP6syC8yFLU50Fp8EMU7l/guOI/YGmF5scP33FMsTz6Jr8dVJUdCB85FVSkcf2
 p/1KmkCsJv+Qp95ROzifo0AzRPqkvH+qcLVchUb49BLZEGjqhIGL/rxKhaKoNbsO7sRogmz0L
 qiEPM30S2hQ1oGBG7GtAtfg/68GDR8vTEMUJwRUhk443fgD9odR16isEgFJSjJsjqg8F0na5x
 qhVrXPfuprv4rwldmaCDd42gAMPm8cJn7d2HdWCj95IEEUPOTWwchaCz4cVMIWdlad18xxVVY
 e0E1RQ+3eaM521wc5KJbKpdhEh66t0Z+WlmGM2VMgmBI83WAr4pO5Xzctrzy/z95e6lAk+REo
 Omf4D+7V9kYSsKgK397kybJFnQJiwqIU0k06jTGFhbiKPY5QZsrJI9uWwMbm3D6KTErhMbCIx
 j5k7DQwnO0z8S035Tc0rmOPy5q7ZaKDu0njcoX4cpX5GskWdrzodM3XcVE5XGCsvnI6XJkv/r
 +8pTc+SRRiKle/4TGwKsNVJ398yHX+FMsim1KV//m2v/WwFlGmrMo8ZCrERMvmEDWtlA291Vb
 s67gGWEDzxroXGG0rDsF6vRHR+NKuVX6gafMfi10ROCnHo0lg6s6CdFNF7wxROU8q019pcOyf
 Wpxz76aPQ8Yfi2GkbQRvjcU4fneeQCqsgTBX5qPI0jIxvLZdI5Hw0kZzcTI4IftJuseRUVjNI
 yttRqbW5XdEqrBnugietHdTz4tJ0Ty42HOPEDj4F25y8n8D+CfekDizz6MbRBysmk6ch+QQum
 ZrsqJJkqoys0O656iLhO+DYLtOD1cHvqQKWceYAUtK4eD6KrXbKyGcv9eMh6YkZLrP6r3ykNa
 aUKuhjIkbO3PQn/hX835ZC1NgPUqZXsBKQCCXO42eDaSqi2JcrMLTrxkkT50O5KZvsrGndGDy
 uAf9zd1h+czrM6+fXeAbumTQodIK2dN30CxHARaSKlsiOH9qZlXLjIQ8c2FtFfeqYPMNqtqZV
 0/Rw6FpZvyr2+76yqjJBmLj6X6qfacSDsJmLp9HZnbxscWPNgPyxmvB+l9utJOAtuQ184prEU
 0qyJlWG0dFwu07mGIokffTc4xoy+qJSA5nmHpGjhfcxGDqlLUeIh3VtBDfsja8pNj8mD/9E/B
 NCWUW2D6RK1yNoRHXtGIrEFNJzwwbSpc7gdd16d0F9Gs499JybPUa2z+UgTB45w4MNNeGPvwJ
 Il1kkFUqS4yQlNankBayNZEs0WucRLlKdGb5V1T3aLEXwhEQ3m8aWQJtBBYvkmyCUB4OZV14T
 FzsTDz9DG8V+4QreW5IuR2GqRUSWhz6gbK0WNXjAZ3l6azZyTfB1yX/2npYAkLfPsWG2R3F9i
 /3maSv9BzIU6vSY5UAdlV5i1R8+fiLj6PNM7KAojLTCR7cpNDTMZ88UrY2c2FR4lyTTCMTLYc
 3C0QZNkAe9uNHiloUb8ePR4ZxlCA/rxK/faYwUemCneeXqoWWvG9hX6brruOfyLv2sbQhcj2Q
 BuXRKrZ6Gm2RG9gddEFAhiTWsUytlIfJy5hGQd6/UfLIubI27ckMtDlgmU0P3UzFaA50fKwz8
 a5e+giXW2eIoiItztGuTaqM96kkzPYzwhFLsE4WUnMbrsyAv+n/Fk+3OmWR2l4Bh7RVF5eIyR
 55pOBOzK88y9a+WiNAh7s4mr+IwvnYeoP+TOMekhbDHkpi0vc13Fom3wCfz7sWvtK0PMArSFo
 /Y89kByjWZsZxjOTU3aTP+/1K4qAa8Vo5386V33AW/YPr+a+qGWV6hLPp8748VLeeLWOKPaK0
 9sSaPed6hGc0W+EoWN/HzLur683IMsND16qTNw4ZeS4xsppAlpOU0YFHqgErXg86OCvNLU7IR
 md3/ZQ3D0LTrL3dncXAgxpeZ3/td922Ie5wSxxb8jElBkrE4KUD43yBoWTTBPBNWfrxputNbS
 tNKcMOLTQqiE0Xhkkp0C1yVvc6WSVJuzDQpfGJgsAkJHy/QWiUDGPpm+pK2xc+fpaYRqseBR3
 nuzQKT6UERYqfF/autRdi0nyd/zS+FJrj8L4LY1wJX35SUCg1QNhECoMm7QeikaPqkYuHKwXE
 uIOh639Zs8iah2m4Joy6ZhtzB3ICO/OFpDlPiEO4jOrM7a3s82ai1Jb1PwzPwzAb2IHmJAH40
 d8HvpGrQJvY/g4BeQzUc14mu29TWE69lTSkj3aTcubgXc+xx1WHV1XFp8hkff8h5cawf/1CXq
 1XbI3vRzf/AWXCcqwZZBzNyiYehGSAxtZZK7wC4hfldQFw5l7sP/xRaso4h8xcVHrSTkFigdG
 kXKpuQwydVNvEkEyAncUEzk27H3N2/u07AYjiWDsHR0l7ND12rdmcu9QMBnCQHZMxEUH5x8QD
 kwDOU9/UCtKUrT9ahWhXUZpXf14HUFHvUt+ZI0uOjaqtvM1Infz1csldLQycgKOgpAk7cBPRs
 3SVrYENPx+rvCHsmAEUwfvpBY42J5jbuVfufVwdxZXm0GHaxLN7YQ7EKeoHHXKB1tvaLFsep1
 uG8hKcSWTcElU/5GG3XF3IIEKw2fk7WL1/EcaS8oGWEZty1mcC6FHV9OSQa+xn2cJvKRNUj7E
 5eC22kweYgOwu4T/cY6yzFplwW/LMY6o+q5DFeX9ruYHq5TSlge9v9yn56xpkF6wHkXLSpYr6
 BR2mfgDa1gzqn9MPKOB2UpcQqWiWPBxocVCL5qoaf0qECt2VC9yj+U6yo4d0RTIHaHPOug6CC
 BsvOrGFSd3lTGH8kNr97CDmMS/Q2t1JBIDPYXVWWxzlb5wmLvnKYbQmXDG8px/JskpDEB6t7J
 LnmYjsjQyUqlbhImfT86qnTUpCRCVheMrhVjJcqyRP1Tnz7Hk2Z51tXarbovmJA/DnicwA/Fs
 Lhq521DIeqMAE20PnJQ+3e0RmrIddK3W9d+xuiw1zT9mxFBI3wEUnXP9+LbkNEBVEbcaYKOgs
 a17bLhnIeGZ1CkMgSqf9CbtOqJe40f3HBnAtNgywb3Seb00EldYMzKx2KCFPzcaNodGs+b/G8
 Xosa8pS1urkWFbe+Tdzzm2+yAIXMwo7PfhQedO3fGDdC3pOmf+8/9Eiq61BGq7AQYTB40W3u0
 HAFWeSfcVd41shhbA/NaTxVqO/OUwL+j3TowcgEvwrGRO1uQsWcHl5vzNamWK9hMoErGkAO9j
 Gu+Ku8iIlVOiXeQqFwvDrApLFZID0CyDJg7CUL/LZfQYmRiVyAdTbIC0/TsmbWyvYFrdE78/k
 6I020hrXrZBWBKpom9llvmwMPVEDpypoOpL9ZgnD0TZf4dL5AEeumJlU5E062YvDleTl/CbRk
 2MryJkhsbh1yNbJPa4cDQO7ib+al4RvPEOs07kVIpOwUwWEuUPWVAaieDhlOzZNLFsiMTnRhX
 N5MGklN4xPlEXF4bshdEGyL5BswNMxYYxRWdPS1aMEcfKJbMTiL18tHaKkaLFK5yIJocd+6TK
 WdYjwSYt5TNsxt6tqMBvZCTkxIaMIHr1oKC3ND5OmOIi/zE4V7qppSrBmuXp+2yBfMdfu+neP
 JhjBpMw5r6XpnhQcyX78SImpEXwgtu9Czdsr4yEjYrPLyWuYYf1TaoQ4eB+qB5NGHakN5H67H
 ufZyEJCFL6+RsBabte2Zf8xjBKlDfhvKYEGaYOYGBmxDquPgXJA0xXaXbjSdz3bQgVoCTNUCN
 yGx8mZFU/6IveEqldgQbw/ksatHBVx88vMPHS9dTI469VuRizaxYrYFr2aeg/SWB+P/fGDLIY
 08IQgiFxWr6RTfxOxwT3yTwSNbMYUn+FhltnUq6SL428HO1LhXG21vVhEpR5dEzV5UqZf4iKh
 UCMRC6CQxNghrx3ieEycELg5Q9dQ34xiOuzh4lv4nUcPJPyPCe7lQSklMtW21rxzEJojCcgAt
 8gTl0ixyJ8XDgc2X1ta4jXX8tXGwQhdgzZ+wpLkzoONZRkuWbKpiLoEfOPTwEUlU4q5OFX5eh
 trWxTHEt7sdDaVz0+Uv7AznfFEBKhSB+csdoZc+FOwDcUP4/gxYxg69TaHzFF3coPtnxd50fL
 SjY1Y+Z7jigJdoxvF0DzZyi3gbx/25CG3X0Q9ZaldTljEj1NEc3NDIkWUVFB6s1m0LbJQ/cdX
 2SpSYRDUf7qqEo1AsAAKYiPIdeMW5O9bYZTptjPIsS8Maiomft2jHkeUhGyFi1fytDQ3l+roD
 KCW32Gs/Zg6PBK/hLR6em5D5O0tU8WiMtnnpPH845XeOzA6rmiZ3irFzDM2z0pdwL4X3qdEWd
 SDlEmilkTplTzKGpm3Ov9oueFnn+IR1ms6WRIzi5dVwW/mlkm9cXjFusqQMi3iKnyXbrMuxvM
 yonhuA==

Am Donnerstag, dem 21.05.2026 um 14:01 +0200 schrieb Mateusz Guzik:
>=20
> So overall I think we are done here.
>=20
> Thank you for testing and sorry for the breakage.

Just as a reminder, this has not been fixed in linux-next, yet,
up to version next-20260528.

Bert Karwatzki
