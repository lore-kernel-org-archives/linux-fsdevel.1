Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0C36F8F1;
	Mon, 27 Jul 2026 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152948; cv=none; b=DLOuMJ+onueQigoEO3GfmPekPZjgJRvm+oepGVfwKm7bzDmMTRCgonynaVpL96Xlz+MiuiTL3nLa2eN+8BGaWWhcAhk8Vj9g4z0/hWSglxB2o7yLk1nnk7ojCiz86vWNjbmrNPoiaQFjSjOn2Yx/7uvMfZdNbQeyG/k0Uh1dKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152948; c=relaxed/simple;
	bh=c8ZzN0JhUobPXVxZSh/lGWhDPNTa9BlFi4dyKy5S0Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoSal/7EziE+oGioEOOumScqGqm6h/Iw9Cf7znpODP+tM+pzhaveWu+DqsOhkkQtDImHnEwv/XYLehfAu0JEbiXi+NXA0V6NnNQJyLgvVpibEpAdCR34n9p60RiyP5sJ5t30564pjjg8L8HnCUN/rkTBsjGgDKCfA61Uigkoz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmsjsw37; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmsjsw37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA521F000E9;
	Mon, 27 Jul 2026 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785152946;
	bh=0w0Ko2D1WhIaOOti4yqzGm07MqvhsgfFcrNCb6S1Nfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cmsjsw37+O9Ea7DYXKQ81QJsdyIlmeyj7raCrxM467eM3FMA6utMU60EpVPmJE0Lb
	 SE/thTZwuVeENSdB9McBOKoH9DkSJq1vBdXq/WiHTUbFDxMaAAmXpooWRnRu5zVYAk
	 t5Ac7HFMQ0Z0Jut5D1aReTYbgvJZx/pXijt5jRAJOEqlYu1y5vKTKvhYTRtmRapo3s
	 yoUb6FSALQHKU5kXsyK2FHhOL9Bf4AuUpFGj+W0FwcTxkpD0wT5bKyM5JW93i1rB7X
	 aZhti1cZgu6S4UgVCP7Sgz1PlzuBF48vgO3vp1MqCSqFhcCwcuNUnen/WyPjwwFrsm
	 BcVHvyBfLZFbw==
Date: Mon, 27 Jul 2026 12:48:57 +0100
From: Mark Brown <broonie@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 13/15] mm/vma: make MAP_PRIVATE-mapped /dev/zero
 mappings truly anonymous
Message-ID: <9d2c8f26-aaee-459f-b73f-d07d8671e805@sirena.org.uk>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <20260720-b4-scalable-cow-virt-pgoff-v2-13-2d549757a76f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+RvKojDw0qW+zzpI"
Content-Disposition: inline
In-Reply-To: <20260720-b4-scalable-cow-virt-pgoff-v2-13-2d549757a76f@kernel.org>
X-Cookie: revolutionary, adj.:


--+RvKojDw0qW+zzpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 03:38:39PM +0100, Lorenzo Stoakes (ARM) wrote:
> When mapping /dev/zero with MAP_PRIVATE, one ends up with strange VMAs
> originating from Linux's distant past.
>=20
> These have vma->vm_file set but NULL vma->vm_ops, meaning they satisfy
> vma_is_anonymous() but otherwise resemble a file-backed VMA.

I'm seeing a test failure in the proc proc-self-map-files-0002 kselftest
which bisects to this change in -next.  The test just says:

# selftests: proc: proc-self-map-files-002
not ok 11 selftests: proc: proc-self-map-files-002 # exit=3D1

which isn't super informative.  Full log at:

   https://lava.sirena.org.uk/scheduler/job/3030495#L13846

bisect log:

# bad: [c5e32e86ca02b003f86e095d379b38148999293d] Add linux-next specific f=
iles for 20260726
# good: [692519a077bfb1a66d209e713d2210bb1d9adcaf] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [ef4f2357df6e9dd6213ce00d01253f3c458d5df0] regmap: clean up kernel-=
doc comments
# good: [86e9ba573c353afd1a46816682f4cc3dbabeeb23] irqchip/irq-imgpdc: Remo=
ve unused driver
git bisect start 'c5e32e86ca02b003f86e095d379b38148999293d' '692519a077bfb1=
a66d209e713d2210bb1d9adcaf' 'ef4f2357df6e9dd6213ce00d01253f3c458d5df0' '86e=
9ba573c353afd1a46816682f4cc3dbabeeb23'
# test job: [ef4f2357df6e9dd6213ce00d01253f3c458d5df0] https://lava.sirena.=
org.uk/scheduler/job/3020719
# test job: [86e9ba573c353afd1a46816682f4cc3dbabeeb23] https://lava.sirena.=
org.uk/scheduler/job/2955047
# test job: [c5e32e86ca02b003f86e095d379b38148999293d] https://lava.sirena.=
org.uk/scheduler/job/3030495
# bad: [c5e32e86ca02b003f86e095d379b38148999293d] Add linux-next specific f=
iles for 20260726
git bisect bad c5e32e86ca02b003f86e095d379b38148999293d
# test job: [673a43d4e283e8fc3bee7a874766278427263bc1] https://lava.sirena.=
org.uk/scheduler/job/3030777
# bad: [673a43d4e283e8fc3bee7a874766278427263bc1] Merge branch 'libcrypto-n=
ext' of https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
git bisect bad 673a43d4e283e8fc3bee7a874766278427263bc1
# test job: [5dd91aac4216c19e9eeea6e0c1a04bcb3e43a876] https://lava.sirena.=
org.uk/scheduler/job/3031099
# bad: [5dd91aac4216c19e9eeea6e0c1a04bcb3e43a876] Merge branch 'xtensa-for-=
next' of https://github.com/jcmvbkbc/linux-xtensa.git
git bisect bad 5dd91aac4216c19e9eeea6e0c1a04bcb3e43a876
# test job: [457b365bc545636d75f65067d18afa86f6ced162] https://lava.sirena.=
org.uk/scheduler/job/3031248
# bad: [457b365bc545636d75f65067d18afa86f6ced162] Merge branch 'for-next' o=
f https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect bad 457b365bc545636d75f65067d18afa86f6ced162
# test job: [a8fa5c7be42a37866fcc315470df3307f0583c47] https://lava.sirena.=
org.uk/scheduler/job/3031351
# good: [a8fa5c7be42a37866fcc315470df3307f0583c47] mm/vma: update create_in=
it_stack_vma() to use vma_flags_t
git bisect good a8fa5c7be42a37866fcc315470df3307f0583c47
# test job: [5c9f41c7115f0e16b7e133abca791a4860bee0b6] https://lava.sirena.=
org.uk/scheduler/job/3031429
# bad: [5c9f41c7115f0e16b7e133abca791a4860bee0b6] Merge branch 'kbuild-for-=
next' of https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git
git bisect bad 5c9f41c7115f0e16b7e133abca791a4860bee0b6
# test job: [c68210527d235e59afa54bc6aba6ecc532488a82] https://lava.sirena.=
org.uk/scheduler/job/3031482
# bad: [c68210527d235e59afa54bc6aba6ecc532488a82] mm: page_alloc: fix non-m=
ovable reclaim storm in defrag_mode
git bisect bad c68210527d235e59afa54bc6aba6ecc532488a82
# test job: [497078da29fbfe6ae057c020f1e5717ded142471] https://lava.sirena.=
org.uk/scheduler/job/3031540
# good: [497078da29fbfe6ae057c020f1e5717ded142471] mm/huge_memory: fold spl=
it_folio_to_list_to_order() into split_folio_to_order()
git bisect good 497078da29fbfe6ae057c020f1e5717ded142471
# test job: [2afd297a9a621ad41892bc0a05481110f46ebfc2] https://lava.sirena.=
org.uk/scheduler/job/3031619
# bad: [2afd297a9a621ad41892bc0a05481110f46ebfc2] tools/testing/vma: add te=
st to assert MAP_PRIVATE-/dev/zero is anon
git bisect bad 2afd297a9a621ad41892bc0a05481110f46ebfc2
# test job: [a4beb459e21af80c1d8c37b079686753c21932ca] https://lava.sirena.=
org.uk/scheduler/job/3031661
# good: [a4beb459e21af80c1d8c37b079686753c21932ca] mm/vma: introduce VMA vi=
rtual page offset field and add helpers
git bisect good a4beb459e21af80c1d8c37b079686753c21932ca
# test job: [84bd1aceb0233c3de9064028d31a16ecf50070d9] https://lava.sirena.=
org.uk/scheduler/job/3031711
# good: [84bd1aceb0233c3de9064028d31a16ecf50070d9] mm/rmap: track whether t=
he page VMA mapped walk is anonymous
git bisect good 84bd1aceb0233c3de9064028d31a16ecf50070d9
# test job: [880b6fe7442df760fe0a726b5f5e568bc6b450b6] https://lava.sirena.=
org.uk/scheduler/job/3031752
# good: [880b6fe7442df760fe0a726b5f5e568bc6b450b6] tools/testing/vma: expan=
d VMA merge tests to assert virt pgoff
git bisect good 880b6fe7442df760fe0a726b5f5e568bc6b450b6
# test job: [e2ad1c5a1f0a96a4a0435213b0a5cb963dc501c5] https://lava.sirena.=
org.uk/scheduler/job/3031804
# good: [e2ad1c5a1f0a96a4a0435213b0a5cb963dc501c5] mm/vma: only permit MAP_=
PRIVATE /dev/zero to be mapped anonymous
git bisect good e2ad1c5a1f0a96a4a0435213b0a5cb963dc501c5
# test job: [9f2782812095787d87ee6b742899ae37966ef0f5] https://lava.sirena.=
org.uk/scheduler/job/3031854
# bad: [9f2782812095787d87ee6b742899ae37966ef0f5] mm/vma: make MAP_PRIVATE-=
mapped /dev/zero mappings truly anonymous
git bisect bad 9f2782812095787d87ee6b742899ae37966ef0f5
# first bad commit: [9f2782812095787d87ee6b742899ae37966ef0f5] mm/vma: make=
 MAP_PRIVATE-mapped /dev/zero mappings truly anonymous

--+RvKojDw0qW+zzpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpnRagACgkQJNaLcl1U
h9Bkbwf/e1ODlSOmYYDgjTGxH9Mk9+t+qWq57eHHh2tng+aAtgOYIW7WjPmZfHso
zIa+M5BdWiAl+KKi/wqQbWiULlh9G2UjzkWDFbfFQ3Bfs7RkB4sZ/nlfB4rZ7d97
9oXQcb7JTOA6iM+zSLN1gCywjiDd4MoVHa7CKNwNCnZ8lNGIkO2bCqXk6hc0YGw6
SrD/lYIvzuIfUwt4r15iqsAvasl7+PzNq8KPId2XImeeWimy0lhF+63P2ek2iS+X
lF2pox3VQ1S2KqJhde///oKeBnHk55l+LVRGQk/sDGsKY7AKJFVIUUXxYSgDFX3r
v7ywTTFl0t/5qQhsnrPTTwJEh15R2A==
=tNdo
-----END PGP SIGNATURE-----

--+RvKojDw0qW+zzpI--
